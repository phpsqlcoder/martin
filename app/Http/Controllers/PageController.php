<?php

namespace App\Http\Controllers;

use App\EmailRecipient;
use Facades\App\Helpers\ListingHelper;
use App\Helpers\Webfocus\Setting;
use App\Permission;
use App\Menu;
use App\Page;
use App\Album;
use App\Article;
use App\Category;
use Response;
use Auth;
use Storage;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Http\Requests\PagePost;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Validator;

class PageController extends Controller
{
    private $searchFields = ['name'];
    private $advanceSearchFields = ['album_id', 'name', 'label', 'contents', 'status', 'meta_title', 'meta_keyword', 'meta_description', 'user_id', 'updated_at1', 'updated_at2'];

    public function __construct()
    {
        Permission::module_init($this, 'page');
    }

    public function index(Request $request)
    {
        $pages = ListingHelper::simple_search(Page::class, $this->searchFields);

        $filter = ListingHelper::get_filter($this->searchFields);

        $advanceSearchData = ListingHelper::get_search_data($this->advanceSearchFields);
        $uniquePagesByAlbum = ListingHelper::get_unique_item_by_column(Page::class, 'album_id');
        $uniquePagesByUser = ListingHelper::get_unique_item_by_column(Page::class, 'user_id');

        $searchType = 'simple_search';

        return view('admin.pages.index', compact('pages', 'filter', 'advanceSearchData', 'uniquePagesByAlbum', 'uniquePagesByUser', 'searchType'));
    }

    public function advance_index(Request $request)
    {
        $equalQueryFields = ['album_id', 'status', 'user_id'];

        $pages = ListingHelper::advance_search(Page::class, $this->advanceSearchFields, $equalQueryFields);

        $filter = ListingHelper::get_filter($this->searchFields);

        $advanceSearchData = ListingHelper::get_search_data($this->advanceSearchFields);
        $uniquePagesByParent = ListingHelper::get_unique_item_by_column(Page::class, 'parent_id');
        $uniquePagesByAlbum = ListingHelper::get_unique_item_by_column(Page::class, 'album_id');
        $uniquePagesByUser = ListingHelper::get_unique_item_by_column(Page::class, 'parent_page_id');

        $searchType = 'advance_search';

        return view('admin.pages.index', compact('pages', 'filter', 'advanceSearchData', 'uniquePagesByParent', 'uniquePagesByAlbum', 'uniquePagesByUser', 'searchType'));
    }

    public function create()
    {
        $albums = Album::where('type', 'sub_banner')->get();
        $pages = Page::where('page_type', '=', 'standard')->get();

        return view('admin.pages.create', compact('albums', 'pages'));
    }


    public function store(PagePost $request)
    {
        $parentPageId = $this->check_parent_page_if_exist($request->parent_page);
        $slugArr = ['slug' => Page::convert_to_slug($request->page_title, $parentPageId)];

//        Validator::make($slugArr, [
//            'slug'            =>  'required|unique:pages,slug',
//        ])->validate();

        /** Handles the banner of the page **/
        $album_id = '0';
        $image_url = '';
        if ($request->banner_type == 'banner_slider') {
            $album_id = $request->page_banner;
            $image_url = '';
        }

        if ($request->banner_type == 'banner_image') {
            $album_id = '0';

            if ($request->hasFile('page_image')) {
                $image_url = $this->upload_file_to_storage('banners', $request->file('page_image'), 'url');
            }
        }

        /** End of Banner Handling **/

        $slug = Page::convert_to_slug($request->page_title, $parentPageId);

        $page = Page::create([
            'album_id' => $album_id,
            'slug' => $slug,
            'parent_page_id' => $parentPageId,
            'name' => $request->page_title,
            'label' => $request->label,
            'contents' => $request->content,
            'status' => $request->has('visibility') ? 'PUBLISHED' : 'PRIVATE',
            'page_type' => 'standard',
            'image_url' => $image_url,
            'meta_title' => $request->seo_title,
            'meta_keyword' => $request->seo_keywords,
            'meta_description' => $request->seo_description,
            'user_id' => Auth::id(),
        ]);

//        if ($this->login_user_is_a_contributor()) {
//            $approvers  = User::where('role_id', 2)->get();
//
//            foreach ($approvers as $approver) {
//                \Mail::to($approver->email)->send(new ContributorAddPage(Setting::info(), $approver));
//            }
//        }

        return redirect()->route('pages.index')->with('success', __('standard.pages.create_success'));
    }

    public function create_new_file_name($oldFileName)
    {
        $fileNames = explode(".", $oldFileName);
        $count = 2;
        $newFilename = $fileNames[0] . ' (' . $count . ').' . $fileNames[1];
        while (Storage::disk('public')->exists($newFilename)) {
            $count += 1;
            $newFilename = $fileNames[0] . ' (' . $count . ').' . $fileNames[1];
        }

        return $newFilename;
    }

    public function edit(Page $page)
    {
        $albums = Album::where('type', 'sub_banner')->get();
        $parentPages = Page::where('id', '!=', $page->id)->where('page_type', '=', 'standard')->get();
        $pageAlbum = $page->album;

        if ($page->is_contact_us_page()) {
            $settings = \App\Setting::find(1);
            $emails = EmailRecipient::email_list_str();

            return view('admin.pages.contact-us', compact('page', 'parentPages', 'albums', 'pageAlbum', 'settings', 'emails'));
        } else if ($page->is_default_page()) {
            return view('admin.pages.default', compact('page'));
        } else if ($page->is_customize_page()) {
            return view('admin.pages.customize', compact('page', 'parentPages', 'albums', 'pageAlbum'));
        } else {
            return view('admin.pages.edit', compact('page', 'parentPages', 'albums', 'pageAlbum'));
        }
    }

    public function update(PagePost $request, Page $page)
    {
        $parentPageId = $this->check_parent_page_if_exist($request->parent_page);

        $album_id = '0';
        $image_url = $page->image_url;
        if ($request->banner_type == 'banner_slider') {
            $album_id = $request->page_banner;
            Storage::disk('public')->delete($page->get_image_url_storage_path());
        }

        if ($request->has('delete_image')) {
            Storage::disk('public')->delete($page->get_image_url_storage_path());
            $image_url = '';
        }

        if ($request->banner_type == 'banner_image') {
            $album_id = '0';
            if ($request->hasFile('page_image')) {
                $image_url = $this->upload_file_to_storage('banners', $request->file('page_image'), 'url');
                Storage::disk('public')->delete($page->get_image_url_storage_path());
            }
        }

        $old_page = Page::whereId($page->id)->first();
        if ($page->name == $request->page_title && $page->parent_page_id == $parentPageId) {
            $slug = $old_page->slug;
        } else {
            $slug = Page::convert_to_slug($request->page_title, $parentPageId);
        }

        $page->update([
            'label' => $request->label,
            'album_id' => $album_id,
            'slug' => $slug,
            'parent_page_id' => $parentPageId,
            'name' => $request->page_title,
            'contents' => $request->content,
            'status' => $request->has('visibility') ? 'PUBLISHED' : 'PRIVATE',
            'image_url' => $image_url,
            'meta_title' => $request->seo_title,
            'meta_keyword' => $request->seo_keywords,
            'meta_description' => $request->seo_description,
            'user_id' => Auth::id(),
        ]);

        return back()->with('success', __('standard.pages.update_success'));
    }

    public function update_default(Request $request, Page $page)
    {
        $updateData = $request->validate([
            'label' => 'required|max:150',
            'content' => 'required',
            'meta_title' => 'max:60',
            'meta_description' => 'max:160',
            'meta_keyword' => 'max:160',
        ]);

        $updateData['contents'] = $updateData['content'];
        $updateData['user_id'] = auth()->id();

        $page->update($updateData);

        return back()->with('success', __('standard.pages.update_success'));
    }

    public function update_customize(Request $request, Page $page)
    {
        $updateData = $request->validate([
            'page_title' => 'required|max:150',
            'label' => 'required|max:150',
            'parent_page' => 'nullable|exists:page,id',
            'page_banner' => 'nullable',
            'visibility' => '',
            'meta_title' => 'max:60',
            'meta_description' => 'max:160',
            'meta_keyword' => 'max:160',
        ]);

        /** Handles the banner of the page **/
        $album_id = '0';
        $image_url = $page->image_url;
        if ($request->banner_type == 'banner_slider') {
            $album_id = $request->page_banner;
            Storage::disk('public')->delete($page->get_image_url_storage_path());
        }

        if ($request->has('delete_image')) {
            Storage::disk('public')->delete($page->get_image_url_storage_path());
            $image_url = '';
        }

        if ($request->banner_type == 'banner_image') {
            $album_id = '0';
            if ($request->hasFile('page_image')) {
                $image_url = $this->upload_file_to_storage('banners', $request->file('page_image'), 'url');
                Storage::disk('public')->delete($page->get_image_url_storage_path());
            }
        }

        $updateData['name'] = $updateData['page_title'];
        $updateData['status'] = $request->has('visibility') ? 'PUBLISHED' : 'PRIVATE';
        $updateData['image_url'] = $image_url;
        $updateData['album_id'] = $album_id;
        $updateData['user_id'] = auth()->id();

        $page->update($updateData);

        return back()->with('success', __('standard.pages.update_success'));
    }

    public function update_contact_us(Request $request, Page $page)
    {
        $updateData = $request->validate([
            'page_title' => 'required|max:150',
            'label' => 'required|max:150',
            'content' => '',
            'emails' => function ($attribute, $value, $fail) {
                if (empty($value)) {
                    $fail('The email recipients field is required.');
                } else {
                    $emails = explode(',', $value);

                    $invalidEmails = [];
                    foreach ($emails as $email) {
                        if (!filter_var( $email, FILTER_VALIDATE_EMAIL )) {
                            $invalidEmails[] = $email;
                        }
                    }

                    if (count($invalidEmails)) {
                        $lastIndex = count($invalidEmails) - 1;

                        if ($lastIndex == 0) {
                            $fail($email . ' is invalid email.');
                        } else {
                            $lastEmail = $invalidEmails[$lastIndex];
                            unset($invalidEmails[$lastIndex]);
                            $emails = implode(', ', $invalidEmails);
                            $fail($emails . ' and ' . $lastEmail . ' are invalid email.');
                        }
                    }
                }
            },
            'content2' => 'required',
            'page_banner' => 'nullable',
            'visibility' => '',
            'seo_title' => 'max:60',
            'seo_description' => 'max:160',
            'seo_keywords' => 'max:160',
        ]);

        /** Handles the banner of the page **/
        $album_id = '0';
        $image_url = $page->image_url;
        if ($request->banner_type == 'banner_slider') {
            $album_id = $request->page_banner;
            Storage::disk('public')->delete($page->get_image_url_storage_path());
        }

        if ($request->has('delete_image')) {
            Storage::disk('public')->delete($page->get_image_url_storage_path());
            $image_url = '';
        }

        if ($request->banner_type == 'banner_image') {
            $album_id = '0';
            if ($request->hasFile('page_image')) {
                $image_url = $this->upload_file_to_storage('banners', $request->file('page_image'), 'url');
                Storage::disk('public')->delete($page->get_image_url_storage_path());
            }
        }

        $updateData['name'] = $updateData['page_title'];
        $updateData['contents'] = $request->get('content');
        $updateData['status'] = $request->has('visibility') ? 'PUBLISHED' : 'PRIVATE';
        $updateData['image_url'] = $image_url;
        $updateData['album_id'] = $album_id;
        $updateData['user_id'] = auth()->id();

        $page->update($updateData);

        $settings = \App\Setting::find(1);
        $settings->update([
            'contact_us_email_layout' => $request->get('content2')
        ]);

        $this->add_and_remove_email_recipients($request->get('emails'));

        return back()->with('success', __('standard.pages.update_success'));
    }

    public function destroy(Page $page)
    {
        if ($this->is_deletable($page) && $page->delete()) {
            return back()->with('success', __('standard.pages.delete_success'));
        } else {
            return back()->with('error', __('standard.pages.delete_failed'));
        }
    }

    public function show($id)
    {

    }

    public function get_slug(Request $request)
    {
        return Page::convert_to_slug($request->url, $request->parentPage);
    }

    public function check_if_slug_exists_on_update($url, $id)
    {
        $slug = Str::slug($url, '-');

        if (Page::where('slug', '=', $slug)->where('id', '<>', $id)->exists()) {
            return true;
        } elseif (Article::where('slug', '=', $slug)->exists()) {
            return true;
        } elseif (Category::where('slug', '=', $slug)->exists()) {
            return true;
        } else {
            return false;
        }
    }

    public function view($slug)
    {
        $page = Page::where('slug', $slug)->first();
        $menu = Menu::where('is_active', 1)->first();
        $settings = Setting::info();

        $breadcrumb = $this->breadcrumb($page);


        return view('theme.'.env('FRONTEND_TEMPLATE').'.main', compact('page', 'breadcrumb', 'menu', 'settings'));
    }

    public function breadcrumb($page)
    {
        return [
            'home' => '/home',
            $page->name => '/page/'.$page->slug
        ];
    }

    public function search()
    {
        $params = Input::all();

        return $this->index($params);
    }

    public function change_status(Request $request)
    {
        $pages = explode("|", $request->pages);

        foreach ($pages as $page) {
            $publish = Page::where('status', '!=', $request->status)
            ->whereId($page)
            ->update([
                'status'  => $request->status,
                'user_id' => Auth::user()->id
            ]);
        }

        return back()->with('success', __('standard.pages.status_success', ['STATUS' => $request->status]));
    }

    public function delete(Request $request)
    {
        $pages = explode("|", $request->pages);

        foreach ($pages as $pageId) {
            $page = Page::find($pageId);

            if ($page && $this->is_deletable($page)) {
                $page->update([ 'user_id' => Auth::user()->id ]);
                $page->delete();
            }
        }

        return back()->with('success', __('standard.pages.delete_success'));
    }

    public function is_deletable($page)
    {
        return $page->page_type == 'standard';
    }

    public function restore($page)
    {
        Page::withTrashed()->find($page)->update(['user_id' => Auth::id() ]);
        $restorePage = Page::whereId($page)->restore();

        return back()->with('success', __('standard.pages.restore_success'));
    }

    public function add_and_remove_email_recipients($emails)
    {
        $emails = explode(',', $emails);
        EmailRecipient::whereNotIn('email', $emails)->delete();
        $registeredEmails = EmailRecipient::select('email')->pluck('email')->toArray();

        $newEmails = array_diff($emails, $registeredEmails);

        foreach ($newEmails as $email) {
            EmailRecipient::create(['email' => $email]);
        }
    }

    public function login_user_is_a_contributor()
    {
        return auth()->user()->role_id == 3;
    }

    public function upload_file_to_storage($folder, $file, $key = '')
    {
        $fileName = $file->getClientOriginalName();
        if (Storage::disk('public')->exists($folder.'/'.$fileName)) {
            $fileNames = explode(".", $fileName);
            $count = 2;
            $newFilename = $fileNames[0].' ('.$count.').'.$fileNames[1];
            while (Storage::disk('public')->exists($folder.'/'.$newFilename)) {
                $count += 1;
                $newFilename = $fileNames[0].' ('.$count.').'.$fileNames[1];
            }

            $fileName = $newFilename;
        }

        $path = Storage::disk('public')->putFileAs($folder, $file, $fileName);
        $url = Storage::disk('public')->url($path);
        $returnArr = [
            'name' => $fileName,
            'url' => $url
        ];

        if ($key == '') {
            return $returnArr;
        } else {
            return $returnArr[$key];
        }
    }

    public function check_parent_page_if_exist($parentPage)
    {
        return isset($parentPage) && $parentPage != null ? $parentPage : '0';
    }
}

<?php

namespace App\Http\Controllers\Category;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Category;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\File;
use Carbon\Carbon;

class CategoryController extends Controller
{
    public function index(){
        $data = Category::all();
        return response()->json($data, 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string',
            'desc' => 'nullable|string',
            // 'icon' => 'nullable|image|max:2048',
        ]);
        
        if ($request->hasFile('file')) {
            $file = $request->file('file');
            
            // Menambahkan timestamp dari Carbon di depan nama file
            $fileName = Carbon::now()->timestamp . '-' . $file->getClientOriginalName();
            
            // Ambil nama file lama (untuk penghapusan jika diperlukan)
            $fileNameOld = $request->input('imageOld'); 
            
            $pathFile = public_path('images/category/');
            
            // Hapus file lama jika ada
            if (File::exists($pathFile . $fileNameOld)) {
                File::delete($pathFile . $fileNameOld);
            }
        
            // Pindahkan file baru ke folder public
            $file->move($pathFile, $fileName);
            
            // Simpan nama file dengan timestamp di kolom 'icon'
            $validated['icon'] = $fileName;
        }
        
        $category = Category::create(
            $validated
        );

        return response()->json(['success' => true, 'datas'=>$category],200);
    }

    public function update(Request $request)
    {
        // Validasi input
        $validated = $request->validate([
            'name' => 'required|string',
            'desc' => 'nullable|string',
            // 'file' => 'nullable|image|max:2048',
        ]);

        $category = Category::find($request->id);

        if (!$category) {
            return response()->json(['message' => 'Category not found'], 404);
        }

        // Jika ada file yang diupload
        if ($request->hasFile('file')) {
            // Ambil file baru
            $file = $request->file('file');
            
            // Buat nama file unik dengan timestamp
            $fileName = Carbon::now()->timestamp . '-' . $file->getClientOriginalName();
            
            // Path untuk penyimpanan file
            $pathFile = public_path('images/category/');
            
            // Hapus file lama jika ada
            if (File::exists($pathFile . $category->icon)) {
                File::delete($pathFile . $category->icon);
            }

            // Pindahkan file baru ke folder
            $file->move($pathFile, $fileName);

            // Update nama file di kolom 'icon'
            $validated['icon'] = $fileName;
        }

        // Update data kategori
        $category->update($validated);

        // Return response
        return response()->json(['message' => 'Category updated successfully', 'datas' => $category], 200);
    }

    public function delete($id)
    {
       // Temukan kategori berdasarkan ID
        $category = Category::find($id);

        if (!$category) {
            return response()->json(['message' => 'Category not found'], 404);
        }

        // Hapus file terkait jika ada
        $pathFile = public_path('images/category/');
        if (File::exists($pathFile . $category->icon)) {
            File::delete($pathFile . $category->icon);
        }

        // Hapus kategori dari database
        $category->delete();

        // Return response
        return response()->json(['message' => 'Category deleted successfully'], 200);
    }
}

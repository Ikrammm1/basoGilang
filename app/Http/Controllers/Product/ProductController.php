<?php

namespace App\Http\Controllers\Product;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\Product;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\File;
use Carbon\Carbon;

class ProductController extends Controller
{
    public function index()
    {
        $data = Product::with([
            'category',
            'stock' => function ($query) {
                $query->selectRaw('product_id, SUM(qty) as total_qty, SUM(qty_frozen) as total_qty_frozen')
                    ->groupBy('product_id');
            }
        ])->get();
        return response()->json($data, 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'code' => 'required|string',
            'name' => 'required|string',
            'price' => 'required',
            'satuan' => 'required',
            'category_id' => 'required|string',
            'desc' => 'nullable|string',
        ]);


        if ($request->hasFile('file')) {
            $file = $request->file('file');
            
            // Menambahkan timestamp dari Carbon di depan nama file
            $fileName = Carbon::now()->timestamp . '-' . $file->getClientOriginalName();
            
            // Ambil nama file lama (untuk penghapusan jika diperlukan)
            $fileNameOld = $request->input('imageOld'); 
            
            $pathFile = public_path('images/product/');
            
            // Hapus file lama jika ada
            if (File::exists($pathFile . $fileNameOld)) {
                File::delete($pathFile . $fileNameOld);
            }
        
            // Pindahkan file baru ke folder public
            $file->move($pathFile, $fileName);
            
            // Simpan nama file dengan timestamp di kolom 'icon'
            $validated['image'] = $fileName;
        }
        
        $product = Product::create(
            $validated
        );

        $new = Product::with('Category')->where('id', $product->id)->first();

        return response()->json(['success' => true, 'datas'=>$new],200);

    }

    public function update(Request $request)
    {
        // Validasi input
        $validated = $request->validate([
           'code' => 'required|string',
            'name' => 'required|string',
            'price' => 'required',
            'satuan' => 'required',
            'category_id' => 'required|string',
            'desc' => 'nullable|string',
        ]);

        $product = Product::find($request->id);

        if (!$product) {
            return response()->json(['message' => 'product not found'], 404);
        }

        // Jika ada file yang diupload
        if ($request->hasFile('file')) {
            // Ambil file baru
            $file = $request->file('file');
            
            // Buat nama file unik dengan timestamp
            $fileName = Carbon::now()->timestamp . '-' . $file->getClientOriginalName();
            
            // Path untuk penyimpanan file
            $pathFile = public_path('images/product/');
            
            // Hapus file lama jika ada
            if (File::exists($pathFile . $product->icon)) {
                File::delete($pathFile . $product->icon);
            }

            // Pindahkan file baru ke folder
            $file->move($pathFile, $fileName);

            // Update nama file di kolom 'icon'
            $validated['image'] = $fileName;
        }

        // Update data kategori
        $product->update($validated);

        $updated = Product::with('Category')->where('id', $product->id)->first();



        // Return response
        return response()->json(['message' => 'product updated successfully', 'datas' => $updated], 200);
    }

    public function delete($id)
    {
       // Temukan kategori berdasarkan ID
        $product = Product::find($id);

        if (!$product) {
            return response()->json(['message' => 'product not found'], 404);
        }

        // Hapus file terkait jika ada
        $pathFile = public_path('images/product/');
        if (File::exists($pathFile . $product->icon)) {
            File::delete($pathFile . $product->icon);
        }

        // Hapus kategori dari database
        $product->delete();

        // Return response
        return response()->json(['message' => 'product deleted successfully'], 200);
    }
}

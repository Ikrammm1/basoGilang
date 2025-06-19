<?php

namespace App\Http\Controllers\Stock;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Stock;

class StockController extends Controller
{
    public function index()
    {
        $data = Stock::with('Product')
            ->whereRaw('(qty > 0 OR qty_frozen > 0)')
            ->orderBy('product_id')
            ->orderBy('qty')
            ->get();

        return $data;
    }

    public function update(Request $request)
    {
        $update = Stock::where('id',$request->id)->update([
            'product_id' => $request->productId,
            'qty' => $request->qty,
            'qty_frozen' => $request->qtyFrozen,
        ]);

        $datas = Stock::with('Product')->whereId($request->id)->first();

        return response()->json(['success' => true, 'datas'=>$datas],200);
    }

    public function stockAvailable($category){

        $query = Stock::selectRaw('product_id, SUM(qty) as total_qty, SUM(qty_frozen) as total_qty_frozen')
        ->with('Product')
        ->groupBy('product_id');

    if ($category === 'Fresh') {
        $query->having('total_qty', '>', 0);
    } else {
        $query->having('total_qty_frozen', '>', 0);
    }

    return $query->get();

    }
}

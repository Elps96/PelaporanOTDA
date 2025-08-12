<?php


use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\IndikatorOTDAController;
use App\Http\Controllers\RekomendasiDPRDController;
use App\Http\Controllers\RekomendasiDPRDExport;


// Route::get('/', function () {
//     return view('welcome');
// });

Route::get('/', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::get('/otda', [IndikatorOTDAController::class, 'index'])->name('otda.index');
    Route::post('/otda/{id}/capaian', [IndikatorOTDAController::class, 'storeCapaian'])->name('otda.storeCapaian');
    Route::post('/otda/inovasi/{kodePertanyaan}', [IndikatorOtdaController::class, 'storeInovasi'])->name('otda.storeInovasi');
    Route::get('/otda/inovasi/{kodePertanyaan}/list', [IndikatorOtdaController::class, 'getlistInovasi']);
    Route::delete('/otda/inovasi/{id}', [IndikatorOtdaController::class, 'hapusInovasi']);

    Route::get('/dprd', [RekomendasiDPRDController::class, 'index'])->name('dprd.index');
    Route::post('/dprd/tindak-lanjut/{kodeRekomendasi}', [RekomendasiDPRDController::class, 'storeTindakLanjut'])->name('dprd.storeTindakLanjut');
    Route::get('/export-excel', [RekomendasiDPRDExport::class, 'export'])->name('export.excel');

});

require __DIR__.'/auth.php';

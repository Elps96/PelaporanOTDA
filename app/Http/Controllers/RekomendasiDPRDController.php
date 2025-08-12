<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Models\RekomendasiDPRD;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;

class RekomendasiDPRDController extends Controller
{
    public function index(Request $request)
    {
        if (!Auth::check()) {
        return redirect()->route('login');
        }

        $OPDPengampu = Auth::user()->name;
        if (!Auth::check()) {
        return redirect()->route('login');
    }
    $OPDPengampu = Auth::user()->name;

    if (strtoupper($OPDPengampu) === 'PEMERINTAHAN') {
        // Tampilkan semua OPD tanpa filter
        $rows = DB::select("
            SELECT
                A.No,
                A.Tahun,
                A.KodeRekomendasiDPRD,
                A.RekomendasiDPRD,
                C.KodeSubRekomendasiDPRD,
                C.SubRekomendasiDPRD,
                COALESCE(B.TindakLanjut, C.TindakLanjut) AS TindakLanjut,
                COALESCE(B.OPDPengampu, C.OPDPengampu) AS OPDPengampu
            FROM tb_rekomendasi_dprd A
            LEFT JOIN tb_rekomendasi_dprd_opd B 
                ON A.KodeRekomendasiDPRD = B.KodeRekomendasiDPRD
            LEFT JOIN tb_rekomendasi_dprd_sub C 
                ON A.KodeRekomendasiDPRD = C.KodeRekomendasiDPRD
        ");
    } else {
        // Filter sesuai OPD yang login
        $rows = DB::select("
            SELECT
                A.No,
                A.Tahun,
                A.KodeRekomendasiDPRD,
                A.RekomendasiDPRD,
                C.KodeSubRekomendasiDPRD,
                C.SubRekomendasiDPRD,
                COALESCE(B.TindakLanjut, C.TindakLanjut) AS TindakLanjut,
                COALESCE(B.OPDPengampu, C.OPDPengampu) AS OPDPengampu
            FROM tb_rekomendasi_dprd A
            LEFT JOIN tb_rekomendasi_dprd_opd B 
                ON A.KodeRekomendasiDPRD = B.KodeRekomendasiDPRD
            LEFT JOIN tb_rekomendasi_dprd_sub C 
                ON A.KodeRekomendasiDPRD = C.KodeRekomendasiDPRD
            WHERE COALESCE(B.OPDPengampu, C.OPDPengampu) = ?
        ", [$OPDPengampu]);
    }

    $data = [];

    foreach ($rows as $row) {
        $kode = $row->KodeRekomendasiDPRD;

        // Inisialisasi rekomendasi utama
        if (!isset($data[$kode])) {
            $data[$kode] = [
                'KodeRekomendasiDPRD' => $kode,
                'Tahun' => $row->Tahun,
                'No' => $row->No,
                'RekomendasiDPRD' => $row->RekomendasiDPRD,
                'OPDPengampu' => [],
                'SubRekomendasiDPRD' => []
            ];
        }

        // Jika tidak ada sub rekomendasi, masukkan langsung ke OPDPengampu
        if (empty($row->SubRekomendasiDPRD)) {
            if ($row->OPDPengampu) {
                $data[$kode]['OPDPengampu'][] = [
                    'NamaOPD' => $row->OPDPengampu,
                    'TindakLanjut' => $row->TindakLanjut ?? ''
                ];
            }
        } else {
            // Ada Sub Rekomendasi
            $kodeSub = $row->KodeSubRekomendasiDPRD;

            // Cek apakah sub sudah masuk
            $subKey = array_search($kodeSub, array_column($data[$kode]['SubRekomendasiDPRD'], 'KodeSubRekomendasiDPRD'));
            if ($subKey === false) {
                $data[$kode]['SubRekomendasiDPRD'][] = [
                    'KodeSubRekomendasiDPRD' => $kodeSub,
                    'SubRekomendasiDPRD' => $row->SubRekomendasiDPRD,
                    'TindakLanjut' => $row->TindakLanjut,
                    'OPDPengampu' => $row->OPDPengampu
                ];
                $subKey = array_key_last($data[$kode]['SubRekomendasiDPRD']);
            }
        }
    }
    // dd($data);
    // Jika request minta JSON, return JSON
    if ($request->wantsJson()) {
        return response()->json(array_values($data));
    }

    // Jika bukan JSON, render ke view
    return view('dprd.index', ['data' => array_values($data)]);
    }

public function storeTindakLanjut(Request $request, $kodeRekomendasi)
{
    try {
        $tahun = session('tahun');
        $opdData = $request->input('TindakLanjut', []);
        $subRekomendasi = $request->input('SubRekomendasiDPRD', []);
        // dd($request->all());
        // dd($tahun);
        if (is_array($opdData) && is_array(reset($opdData))) {
            // Update data dengan sub rekomendasi tanpa insert baru
            foreach ($subRekomendasi as $kodeSub => $sub) {
                if (isset($opdData[$kodeSub])) {
                    foreach ($opdData[$kodeSub] as $opd => $tindakLanjut) {
                    $result = DB::table('tb_rekomendasi_dprd_sub')
                            ->where('KodeRekomendasiDPRD', $kodeRekomendasi)
                            ->where('KodeSubRekomendasiDPRD', $kodeSub)
                            ->where('OPDPengampu', $opd)
                            ->update([
                                'SubRekomendasiDPRD' => $sub,
                                'Tahun' => $tahun,
                                'TindakLanjut' => $tindakLanjut,
                            ]);
                    }
                }
            }
        } else {
            // ➖ Data langsung tanpa sub rekomendasi
            $opd = $request->input('NamaOPD');
            $tindakLanjut = $request->input('TindakLanjut');

            $result = DB::table('tb_rekomendasi_dprd_opd')
                ->where('KodeRekomendasiDPRD', $kodeRekomendasi)
                ->where('OPDPengampu', $opd)
                ->where('Tahun', $tahun)
                ->update([
                    'TindakLanjut' => $tindakLanjut
                ]);
        }
        // if ($result === 0) {
        //     // Gagal
        //     return redirect()->back()->with('toast', [
        //         'type' => 'error', // merah
        //         'message' => 'Update gagal!'
        //     ]);
        // } else {
        //     // Berhasil
        //     return redirect()->back()->with('toast', [
        //         'type' => 'success', // hijau
        //         'message' => 'Update berhasil!'
        //     ]);
        // }

        if ($result === 0) {
            return redirect()->back()->with('error', 'Tindak lanjut gagal disimpan !');
        } else {
            return redirect()->back()->with('success', 'Tindak lanjut berhasil disimpan !');
        }

        // return back()->with('success', 'Tindak lanjut berhasil disimpan.');
        // return response()->json(['success' => true]);
    } catch (\Exception $e) {
        // Simpan error ke log Laravel
        // \Log::error('Gagal menyimpan tindak lanjut: ' . $e->getMessage());

        // Kembalikan ke halaman sebelumnya dengan pesan error
        // return back()->with('error', 'Terjadi kesalahan saat menyimpan tindak lanjut. Silakan coba lagi.');
            $errorMessage = $e->getMessage();
    $errorInfo = method_exists($e, 'errorInfo') ? json_encode($e->errorInfo) : '';

    return redirect()->back()->with(
        'toast_error',
        'Terjadi kesalahan saat memperbarui data. Detail: ' . $errorMessage . ' ' . $errorInfo
    );
    }

}



}

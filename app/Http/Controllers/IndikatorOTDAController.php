<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Models\IndikatorOTDA;
use App\Models\InputCapaian;
use App\Models\InputCapaianInovasi;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;

class IndikatorOTDAController extends Controller
{
    public function index()
    {
        if (!Auth::check()) {
        return redirect()->route('login');
        }

        $OPDPengampu = Auth::user()->name;
        $data = DB::select("
        SELECT	A.Jenis,
                        A.KodePertanyaan,
                        A.`No`,
                        A.Tahun,
                        A.Indikator,
                        A.DefinisiOperasional,
                        A.Rumus,
                        A.BuktiPendukung,
                        A.OPDPengampu,
                        A.JenisInput,
                        A.Pilihan1,
                        A.Pilihan2,
                        B.Capaian,
                        B.Keterangan,
                        B.FileBukti
        FROM		(
                        SELECT 	A.*,
                                        'JenisInput1' AS JenisInput,
                                        'Tepat Waktu' AS Pilihan1,
                                        'Tidak Tepat Waktu' AS Pilihan2
                        FROM 		tb_indikator_komponen_otda A
                        WHERE 	A.KodePertanyaan IN ('FKDH001', 'FKDH002')

                        UNION ALL

                        SELECT 	A.*,
                                        'JenisInput2' AS JenisInput,
                                        'Ada' AS Pilihan1,
                                        'Tidak Ada' AS Pilihan2
                        FROM 		tb_indikator_komponen_otda A
                        WHERE 	A.KodePertanyaan IN ('FKDH004','EKPD008')

                        UNION ALL

                        SELECT 	A.*,
                                        'JenisInput3' AS JenisInput,
                                        'Tepat' AS Pilihan1,
                                        'Tidak Tepat' AS Pilihan2
                        FROM 		tb_indikator_komponen_otda A
                        WHERE 	A.KodePertanyaan IN ('PHD002')

                        UNION ALL

                        SELECT 	A.*,
                                        'JenisInput4' AS JenisInput,
                                        A.RumusIsiAtas AS Pilihan1,
                                        A.RumusIsiBawah AS Pilihan2
                        FROM 		tb_indikator_komponen_otda A
                        WHERE 	A.KodePertanyaan IN ('PHD003','KKPD003','KKPD004','KKPD005','EKPD002','EKPD003','EKPD004','EKPD005','EKPD006','EKPD013')
                        UNION ALL
                        SELECT 	A.*,
                                        'JenisInput5' AS JenisInput,
                                        'Ya' AS Pilihan1,
                                        'Tidak' AS Pilihan2
                        FROM 		tb_indikator_komponen_otda A
                        WHERE 	A.KodePertanyaan IN ('KKPD001','KKPD002')

                        UNION ALL

                        SELECT 	A.*,
                                        'JenisInput6' AS JenisInput,
                                        A.RumusIsiAtas AS Pilihan1,
                                        '' AS Pilihan2
                        FROM 		tb_indikator_komponen_otda A
                        WHERE 	A.KodePertanyaan IN ('EKPKD001','EKPD007','EKPD011','EKPD012')

                        UNION ALL
                        SELECT 	A.*,
                                        'JenisInput7' AS JenisInput,
                                        '' AS Pilihan1,
                                        '' AS Pilihan2
                        FROM 		tb_indikator_komponen_otda A
                        WHERE 	A.KodePertanyaan IN ('EKPD010')
                        UNION ALL
                        SELECT 	A.*,
                                        'JenisInput8' AS JenisInput,
                                        '' AS Pilihan1,
                                        '' AS Pilihan2
                        FROM 		tb_indikator_komponen_otda A
                        WHERE 	A.KodePertanyaan IN ('EKPD009')
                        )	A
        LEFT JOIN	tb_input_capaian B ON A.KodePertanyaan = B.KodePertanyaan
        WHERE			A.OPDPengampu = ?", [$OPDPengampu]
        );

        return view('otda.index', compact('data'));

    }

    public function storeCapaian(Request $request, $id)
    {
        $validated = $request->validate([
            'Capaian' => 'required|string',
            'FileBuktiDukung' => 'nullable|file|max:5120',
            'Keterangan' => 'nullable|string',
            'InputIsianAtas' => 'nullable|integer',
            'InputIsianBawah' => 'nullable|integer'
        ]);
        $tahun = session('tahun');
        // dd($validated);
        // $path = null;
        // Ambil data lama jika ada
        $existing = DB::table('tb_input_capaian')->where('KodePertanyaan', $id)->first();

        // Default path dari data lama
        $path = $existing->FileBukti ?? null;
        if ($request->hasFile('FileBuktiDukung')) {
            $path = $request->file('FileBuktiDukung')->store('bukti_dukung', 'public');
        }
        // Tambahkan hanya jika tidak null
        if (!empty($validated['InputIsianAtas'])) {
            $data['InputIsianAtas'] = $validated['InputIsianAtas'];
        }
        if (!empty($validated['InputIsianBawah'])) {
            $data['InputIsianBawah'] = $validated['InputIsianBawah'];
        }
        // dd($validated);
        DB::table('tb_input_capaian')->updateOrInsert(
            ['KodePertanyaan' => $id],
            [
                'Capaian' => $validated['Capaian'],
                'FileBukti' => $path,
                'Keterangan' => $validated['Keterangan'],
                'InputIsianAtas' => $validated['InputIsianAtas'] ?? null,
                'InputIsianBawah' => $validated['InputIsianBawah'] ?? null,
                'Tahun' => $tahun,
                'UpdateAt' => now()
            ]
        );

        return redirect()->back()->with('success', 'Capaian berhasil disimpan.');
    }

    public function edit($kodePertanyaan)
    {
        $data = DB::table('tb_input_capaian')->where('KodePertanyaan', $kodePertanyaan)->first();
        return response()->json($data);
    }

// OtdaController.php
public function storeInovasi(Request $request, $kodePertanyaan)
{
        $tahun = session('tahun');
    try {
        $request->validate([
            'Nama' => 'required|string|max:255',
            'Deskripsi' => 'required|string',
            'SKPD' => 'required|string|max:255',
            'Gambar' => 'nullable|image|max:2048', // maksimal 2MB
        ]);

        $data = new InputCapaianInovasi();
        $data->KodePertanyaan = $kodePertanyaan;
        $data->Nama = $request->Nama;
        $data->Deskripsi = $request->Deskripsi;
        $data->SKPD = $request->SKPD;
        $data->Tahun = $tahun;

        if ($request->hasFile('Gambar')) {
            $data->Gambar = $request->file('Gambar')->store('inovasi', 'public');
        }

        $data->save();

        return response()->json(['success' => true]);
    } catch (\Throwable $e) {
        return response()->json([
            'success' => false,
            'message' => $e->getMessage(),
        ], 500);
    }
}

public function getListInovasi($kodePertanyaan)
{
    try {
        $data = InputCapaianInovasi::where('KodePertanyaan', $kodePertanyaan)->get();

        $html = view('partials._tabel_inovasi', compact('data'))->render();
        

        return response()->json([
            'success' => true,
            'html' => $html
        ]);
    } catch (\Throwable $e) {
        return response()->json([
            'success' => false,
            'message' => $e->getMessage()
        ], 500);
    }
}

public function hapusInovasi($id)
{
    try {
        $data = InputCapaianInovasi::findOrFail($id);
        if ($data->Gambar && \Storage::exists($data->Gambar)) {
            \Storage::delete($data->Gambar);
        }
        $data->delete();

        return response()->json(['success' => true]);
    } catch (\Throwable $e) {
        return response()->json([
            'success' => false,
            'message' => $e->getMessage()
        ], 500);
    }
}


}

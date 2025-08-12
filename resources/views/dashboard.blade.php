@extends('layouts.app') {{-- sesuaikan dengan nama layout kamu, misalnya 'layouts.app' --}}

@section('header')
    <h2 class="font-semibold text-xl text-gray-800 leading-tight">
        {{ __('Dashboard') }}
    </h2>
@endsection

@section('content')
<div class="py-12">
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg mb-4">
            <div class="p-6 text-gray-900">
                {{ __("You're logged in!") }}
            </div>
        </div>
        @php
        $rowIndikatorOTDA = DB::select("
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
        WHERE			A.OPDPengampu = ?", [Auth::user()->name]
        );
        @endphp


        @php
            $rowsRekomendasiDPRD = DB::select("
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
            ", [Auth::user()->name]);
        @endphp
        
        @if(!empty($rowIndikatorOTDA))
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Indikator Komponen OTDA {{ session('tahun') }}</h5>
                <p class="card-text">Lihat data Indikator Komponen OTDA.</p>
                <a href="{{ route('otda.index') }}" class="btn btn-outline-primary">Lihat Indikator</a>
            </div>
        </div>
        @endif
        @if(!empty($rowsRekomendasiDPRD))
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">Rekomendasi DPRD {{ session('tahun') }}</h5>
                    <p class="card-text">Rekomendasi DPRD berdasar tahun sebelumnya</p>
                    <a href="{{ route('dprd.index') }}" class="btn btn-outline-primary">Lihat Rekomendasi</a>
                </div>
            </div>
        @endif
    </div>
</div>
@endsection

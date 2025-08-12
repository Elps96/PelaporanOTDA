<?php

namespace App\Http\Controllers;

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use App\Models\RekomendasiDPRD;
use Illuminate\Support\Facades\DB;

class RekomendasiDPRDExport extends Controller
{
    public function export()
{
    $spreadsheet = new Spreadsheet();
    $sheet = $spreadsheet->getActiveSheet();

    // Judul
    $sheet->mergeCells('A1:G1');
    $sheet->setCellValue('A1', 'Daftar Rekomendasi DPRD');
    $sheet->getStyle('A1')->getFont()->setBold(true)->setSize(16);
    $sheet->getStyle('A1')->getAlignment()->setHorizontal(Alignment::HORIZONTAL_CENTER);

    // Header
    $headers = ['No', 'Tahun', 'Rekomendasi DPRD', 'Sub Rekomendasi DPRD', 'Tindak Lanjut', 'OPD Pengampu', 'Aksi'];
    $col = 'A';
    foreach ($headers as $header) {
        $sheet->setCellValue($col.'3', $header);
        $col++;
    }

    // Style Header
    $sheet->getStyle('A3:G3')->getFont()->setBold(true);
    $sheet->getStyle('A3:G3')->getFill()->setFillType(Fill::FILL_SOLID)
          ->getStartColor()->setARGB('FFD9E1F2');
    $sheet->getStyle('A3:G3')->getAlignment()->setHorizontal(Alignment::HORIZONTAL_CENTER);

    // Ambil data dari database
            $data = DB::select("
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

    $row = 4;
    $no = 1;
    foreach ($data as $item) {
        $sheet->setCellValue('A'.$row, $no++);
        $sheet->setCellValue('B'.$row, $item->Tahun);
        $sheet->setCellValue('C'.$row, $item->RekomendasiDPRD);
        $sheet->setCellValue('D'.$row, $item->SubRekomendasiDPRD);
        $sheet->setCellValue('E'.$row, $item->TindakLanjut);
        $sheet->setCellValue('F'.$row, $item->OPDPengampu);
        $sheet->setCellValue('G'.$row, ''); // kolom aksi biasanya kosong di export
        $row++;
    }

    // Border
    $styleArray = [
        'borders' => [
            'allBorders' => [
                'borderStyle' => Border::BORDER_THIN,
                'color' => ['argb' => 'FF000000'],
            ],
        ],
    ];
    $sheet->getStyle('A3:G'.($row-1))->applyFromArray($styleArray);

    // Auto width
    foreach (range('A', 'G') as $col) {
        $sheet->getColumnDimension($col)->setAutoSize(true);
    }

    // Download file
    $writer = new Xlsx($spreadsheet);
    $fileName = 'Rekomendasi_DPRD.xlsx';
    $temp_file = tempnam(sys_get_temp_dir(), $fileName);
    $writer->save($temp_file);

    return response()->download($temp_file, $fileName)->deleteFileAfterSend(true);
}
}

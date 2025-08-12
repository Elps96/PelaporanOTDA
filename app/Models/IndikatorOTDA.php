<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class IndikatorOTDA extends Model
{
    use HasFactory;

    protected $table = 'tb_indikator_komponen_otda';

    protected $primaryKey = 'KodePertanyaan'; // <- tambahkan ini

    public $incrementing = false; // jika kolom 'No' bukan auto-increment
    protected $keyType = 'string'; // atau 'int' sesuai tipe kolom di database

    protected $fillable = [
        'Jenis',
        'KodePertanyaan',
        'No',
        'Tahun',
        'Indikator',
        'DefinisiOperasional',
        'Rumus',
        'Capaian',
        'BuktiPendukung',
        'FileBuktiDukung',
        'Keterangan',
        'OPDPengampu',
    ];
}

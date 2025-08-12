<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InputCapaianInovasi extends Model
{
    protected $table = 'tb_input_capaian_inovasi';

    protected $primaryKey = 'No'; // <- primary key bukan 'id'

    public $incrementing = true; // <- auto increment

    const CREATED_AT = 'InputAt';
    const UPDATED_AT = 'UpdateAt';

    protected $fillable = [
        'No',
        'Tahun',
        'KodePertanyaan',
        'Nama',
        'Deskripsi',
        'Gambar',
        'SKPD',
        'IsAktif',
        'InputAt',
        'UpdateAt',
    ];
}

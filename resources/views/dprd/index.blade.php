@extends('layouts.app')

@section('content')
<div class="container">
    @if(session('success'))
    <script>
        toastr.success("{{ session('success') }}");
    </script>
    @endif

    @if(session('error'))
    <script>
        toastr.error("{{ session('error') }}");
    </script>
    @endif

    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="{{ route('dashboard') }}">Dashboard</a></li>
                <li class="breadcrumb-item active" aria-current="page">Daftar Rekomendasi DPRD</li>
            </ol>
        </nav>
    </div>
    <h2 class="mb-4">Daftar Rekomendasi DPRD berdasar tahun sebelumnya</h2>
    @if(Auth::user()->opd === 'PEMERINTAHAN')
        <a href="{{ route('export.excel') }}" class="btn btn-success">Export ke Excel</a>
    @endif


    <table class="table table-bordered table-striped align-middle text-center">
        <thead class="table-primary">
            <tr>
                <th>No</th>
                <th>Tahun</th>
                <th>Rekomendasi DPRD</th>
                <th>Sub Rekomendasi DPRD</th>
                <th>Tindak Lanjut</th></th>
                <th>OPD Pengampu</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
<tbody>
    @foreach ($data as $item)
        @php
            $hasSub = count($item['SubRekomendasiDPRD']) > 0;
            $rowNumber = 1;
        @endphp
        @if ($hasSub)
            {{-- Loop per sub rekomendasi --}}
            @foreach ($item['SubRekomendasiDPRD'] as $sub)
                <tr>
                    <td>{{ $item['No'] }} sub {{ $rowNumber++ }}</td>
                    <td>{{ $item['Tahun'] }}</td>
                    <td class="text-start">{{ $item['RekomendasiDPRD'] }}</td>
                    <td class="text-start">{{ $sub['SubRekomendasiDPRD'] }}</td>
                    <td class="text-start">{!! $sub['TindakLanjut'] ?? '-' !!}</td>
                    <td>{{ $sub['OPDPengampu'] }}</td>
                    <td>
                        <button class="btn btn-sm {{ empty($sub['TindakLanjut']) ? 'btn-danger' : 'btn-success' }}"
                                data-bs-toggle="modal"
                                data-bs-target="#modalTindakLanjutSub{{ $sub['KodeSubRekomendasiDPRD'] }}">
                            {{ empty($sub['TindakLanjut']) ? 'Isi Tindak Lanjut' : 'Ubah Tindak Lanjut' }}
                        </button>

                        {{-- Modal untuk sub rekomendasi --}}
                        <div class="modal fade" id="modalTindakLanjutSub{{ $sub['KodeSubRekomendasiDPRD'] }}" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <form method="POST" action="{{ route('dprd.storeTindakLanjut', $item['KodeRekomendasiDPRD']) }}">
                                    @csrf
                                    <!-- <input type="hidden" name="KodeSubRekomendasiDPRD" value="{{ $sub['KodeSubRekomendasiDPRD'] }}"> -->
                                        <input type="hidden" name="SubRekomendasiDPRD[{{ $sub['KodeSubRekomendasiDPRD'] }}]" value="{{ $sub['SubRekomendasiDPRD'] }}">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Tindak Lanjut Sub Rekomendasi</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body text-start">
                                            <p><strong>Rekomendasi DPRD:</strong> {{ $item['RekomendasiDPRD'] }}</p>
                                            <p><strong>Sub Rekomendasi:</strong> {{ $sub['SubRekomendasiDPRD'] }}</p>
                                            <p><strong>OPD:</strong> {{ $sub['OPDPengampu'] }}</p>
                                            <div class="form-group">
                                                <!-- <label for="TindakLanjut">Tindak Lanjut</label> -->
                                                <label for="TindakLanjut" class="fw-bold fs-5">Tindak Lanjut :</label>
                                                <!-- <textarea name="TindakLanjut" class="form-control summernote" rows="5">{{ $sub['TindakLanjut'] ?? '' }}</textarea> -->
                                                <textarea id = "TindakLanjut" name="TindakLanjut[{{ $sub['KodeSubRekomendasiDPRD'] }}][{{ $sub['OPDPengampu'] }}]" class="form-control summernote" rows="8">{{ $sub['TindakLanjut'] ?? '' }}</textarea>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-success">Simpan</button>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </td>
                </tr>
            @endforeach
        @else
            {{-- Tanpa sub rekomendasi, per OPD --}}
            @foreach ($item['OPDPengampu'] as $opd)
                <tr>
                    <td>{{ $item['No'] }}</td>
                    <td>{{ $item['Tahun'] }}</td>
                    <td class="text-start">{{ $item['RekomendasiDPRD'] }}</td>
                    <td>-</td>
                    <td class="text-start">{!! $opd['TindakLanjut'] ?? '-' !!}</td>
                    <td>{{ $opd['NamaOPD'] }}</td>
                    <td>
                        <button class="btn btn-sm {{ empty($opd['TindakLanjut']) ? 'btn-danger' : 'btn-success' }}"
                                data-bs-toggle="modal"
                                data-bs-target="#modalTindakLanjutOPD{{ $item['KodeRekomendasiDPRD'] }}{{ $loop->index }}">
                            {{ empty($opd['TindakLanjut']) ? 'Isi Tindak Lanjut' : 'Ubah Tindak Lanjut' }}
                        </button>

                        {{-- Modal untuk OPD --}}
                        <div class="modal fade" id="modalTindakLanjutOPD{{ $item['KodeRekomendasiDPRD'] }}{{ $loop->index }}" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <form method="POST" action="{{ route('dprd.storeTindakLanjut', $item['KodeRekomendasiDPRD']) }}">
                                
                                    @csrf
                                    <input type="hidden" name="NamaOPD" value="{{ $opd['NamaOPD'] }}">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Tindak Lanjut Rekomendasi DPRD</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body text-start">
                                            <p><strong>Rekomendasi DPRD:</strong> {{ $item['RekomendasiDPRD'] }}</p>
                                            <p><strong>OPD:</strong> {{ $opd['NamaOPD'] }}</p>
                                            <div class="form-group">
                                                <!-- <label for="TindakLanjut">Tindak Lanjut</label> -->
                                                <label for="TindakLanjut" class="fw-bold fs-5">Tindak Lanjut :</label>
                                                <textarea id="TindakLanjut" name="TindakLanjut" class="form-control summernote" rows="5">{{ $opd['TindakLanjut'] ?? '' }}</textarea>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-success">Simpan</button>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </td>
                </tr>
            @endforeach
        @endif
    @endforeach
</tbody>

    </table>
    <script>
    $(document).ready(function() {
        $('.summernote').summernote({
            height: 200,
            tabsize: 2,
            fontNames: ['Arial', 'Times New Roman', 'Courier New', 'Verdana', 'Georgia'],
            fontNamesIgnoreCheck: ['Arial'],
            fontName: 'Arial',
            toolbar: [
                ['style', ['style']],
                ['font', ['fontname', 'fontsize', 'bold', 'italic', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['insert', ['link']],
                ['view', ['fullscreen', 'codeview', 'help']]
            ],
            callbacks: {
                onInit: function() {
                    $('.note-editable').css('font-family', 'Arial');
                }
            }
        });
    });
    </script>
</div>
@endsection


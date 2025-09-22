@extends('layouts.app')

@section('content')
<div class="container">

    @if (session('success'))
    <script>
        toastr.success({!! json_encode(session('success')) !!});
    </script>
    @endif

    @if (session('error'))
    <script>
        toastr.error({!! json_encode(session('error')) !!});
    </script>
    @endif

    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="{{ route('dashboard') }}">Dashboard</a></li>
                <li class="breadcrumb-item active" aria-current="page">Daftar Indikator OTDA</li>
            </ol>
        </nav>
    </div>
    <h2 class="mb-4">Daftar Indikator Komponen OTDA {{ session('tahun') }}</h2>

    <div class="table-responsive">
    <table class="table table-bordered table-striped align-middle text-center">
        <thead class="table-primary">
            <tr>
                <th>Aksi</th>
                <th>No</th>
                <th>Kode Pertanyaan</th>
                <th>Tahun</th>
                <th>Indikator</th>
                <th>Definisi Operasional</th>
                <th>Rumus</th>
                <th>Capaian</th>
                <th>Bukti Pendukung</th>
                <th>File Bukti Dukung</th>
                <th>Keterangan</th>
                <th>OPD Pengampu</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($data as $index => $item)
                @php
                    $modalId = 'modalCapaian' . preg_replace('/[^A-Za-z0-9]/', '', $item->KodePertanyaan);
                @endphp
                <tr>
                    <td>
                        <button
                            class="btn btn-sm btn-{{ $item->Capaian ? 'success' : 'danger' }}"
                            data-bs-toggle="modal"
                            data-bs-target="#{{ $modalId }}"
                            onclick="loadInovasi('{{ $item->KodePertanyaan }}')"
                        >
                            {{ $item->Capaian ? 'Ubah Capaian' : 'Isi Capaian' }}
                        </button>
                        
                    </td>
                    <td>{{ $item->No }}</td>
                    <td>{{ $item->KodePertanyaan }}</td>
                    <td>{{ $item->Tahun }}</td>
                    <td class="text-start">{{ $item->Indikator }}</td>
                    <td class="text-start">{{ $item->DefinisiOperasional }}</td>
                    <td class="text-start">{{ $item->Rumus }}</td>
                    <td class="text-start">{{ $item->Capaian }}</td>
                    <td class="text-start">{!! nl2br(e($item->BuktiPendukung)) !!}</td>
                    <td>
                        @if ($item->FileBukti)
                            <a href="{{ asset('storage/' . $item->FileBukti) }}" target="_blank">Lihat File</a>
                        @else
                            -
                        @endif
                    </td>
                    <td class="text-start">{{ $item->Keterangan }}</td>
                    <td>{{ $item->OPDPengampu }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
    </div>

    {{-- Letakkan semua modal DI SINI --}}
    @foreach ($data as $item)
    @php
        $input = \App\Models\InputCapaian::where('KodePertanyaan', $item->KodePertanyaan)->first();
        $modalId = 'modalCapaian' . preg_replace('/[^A-Za-z0-9]/', '', $item->KodePertanyaan);
    @endphp
    <div class="modal fade" id="{{ $modalId }}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <form action="{{ route('otda.storeCapaian', $item->KodePertanyaan) }}" method="POST" enctype="multipart/form-data" class="modal-content">
                @csrf
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel{{ $item->KodePertanyaan }}">Input Capaian - {{ $item->KodePertanyaan }}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <!-- Indikator -->
                    <div class="mb-3">
                        <strong>Indikator:</strong>
                        <p>{{ $item->Indikator }}</p>
                    </div>
                    <div class="mb-3">
                        <strong>Definisi Operasional:</strong>
                        <p>{{ $item->DefinisiOperasional }}</p>
                    </div>
                    <div class="mb-3">
                        <strong>Rumus:</strong>
                        <p>{{ $item->Rumus }}</p>
                    </div>

                    <!-- Jika JenisInput4 -->
                    @if ($item->JenisInput == 'JenisInput4')
                        <div class="mb-3">
                            <label class="form-label">{{ $item->Pilihan1 }}</label>
                            <input type="number" step="1" name="InputIsianAtas" id="inputAtas-{{ $item->KodePertanyaan }}" class="form-control" value="{{ $input->InputIsianAtas ?? '' }}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">{{ $item->Pilihan2 }}</label>
                            <input type="number" step="1" name="InputIsianBawah" id="inputBawah-{{ $item->KodePertanyaan }}" class="form-control" value="{{ $input->InputIsianBawah ?? '' }}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Capaian (%)</label>
                            <input type="text" readonly name="Capaian" id="hasilCapaian-{{ $item->KodePertanyaan }}" class="form-control" value="{{ $input->Capaian ?? '' }}">
                        </div>
                        <!-- File Bukti Dukung -->
                        <div class="mb-3">
                            <label class="form-label">File Bukti Dukung</label>
                            <input type="file" name="FileBuktiDukung" class="form-control" {{ $input && $input->FileBukti ? '' : 'required' }}>
                            @if ($input && $input->FileBukti)
                                <small class="text-muted d-block mt-1">
                                    File saat ini: 
                                    <a href="{{ asset('storage/' . $input->FileBukti) }}" target="_blank">Lihat Bukti</a>
                                </small>
                            @endif
                        </div>

                        <!-- Keterangan -->
                        <div class="mb-3">
                            <label class="form-label">Keterangan</label>
                            <textarea name="Keterangan" class="form-control" rows="3">{{ $input->Keterangan ?? '' }}</textarea>
                        </div>

                    <!-- Jika JenisInput6 -->
                    @elseif ($item->JenisInput == 'JenisInput6')
                        <div class="mb-3">
                            <label class="form-label">Nilai Input</label>
                            <input type="number" step="0.01" name="InputIsianAtas" id="inputNilai-{{ $item->KodePertanyaan }}" class="form-control" value="{{ $input->InputIsianAtas ?? '' }}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Capaian</label>
                            <input type="text" readonly name="Capaian" id="hasilCapaian-{{ $item->KodePertanyaan }}" class="form-control" value="{{ $input->Capaian ?? '' }}">
                        </div>
                        <!-- File Bukti Dukung -->
                        <div class="mb-3">
                            <label class="form-label">File Bukti Dukung</label>
                            <input type="file" name="FileBuktiDukung" class="form-control" {{ $input && $input->FileBukti ? '' : 'required' }}>
                            @if ($input && $input->FileBukti)
                                <small class="text-muted d-block mt-1">
                                    File saat ini: 
                                    <a href="{{ asset('storage/' . $input->FileBukti) }}" target="_blank">Lihat Bukti</a>
                                </small>
                            @endif
                        </div>

                        <!-- Keterangan -->
                        <div class="mb-3">
                            <label class="form-label">Keterangan</label>
                            <textarea name="Keterangan" class="form-control" rows="3">{{ $input->Keterangan ?? '' }}</textarea>
                        </div>

                    @elseif ($item->JenisInput == 'JenisInput7')
                        <div class="mb-3">
                            <label class="form-label">Dokumen Gabungan</label>
                        </div>
                        <!-- File Bukti Dukung -->
                        <div class="mb-3">
                            <label class="form-label">File Bukti Dukung</label>
                            <input type="file" name="FileBuktiDukung" class="form-control" {{ $input && $input->FileBukti ? '' : 'required' }}>
                            @if ($input && $input->FileBukti)
                                <small class="text-muted d-block mt-1">
                                    File saat ini: 
                                    <a href="{{ asset('storage/' . $input->FileBukti) }}" target="_blank">Lihat Bukti</a>
                                </small>
                            @endif
                        </div>

                        <!-- Keterangan -->
                        <div class="mb-3">
                            <label class="form-label">Keterangan</label>
                            <textarea name="Keterangan" class="form-control" rows="3">{{ $input->Keterangan ?? '' }}</textarea>
                        </div>
                    @elseif ($item->JenisInput == 'JenisInput8')
                    <!-- Tombol Tambah -->
                        <div id="containerCapaianInovasi-{{ $item->KodePertanyaan }}">
                            <!-- Tombol Tambah -->
                            <div class="d-flex justify-content-end mb-3">
                                <button type="button"
                                    class="btn btn-sm btn-primary"
                                    onclick="bukaSubModalSetelahTutupModalUtama('modalCapaian{{ $item->KodePertanyaan }}', 'modalTambahData-{{ $item->KodePertanyaan }}')">
                                    + Tambah
                                </button>
                            </div>

                            <!-- Tabel -->
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead class="table-light">
                                    <tr>
                                        @if ($item->KodePertanyaan === 'EKPD007')
                                            <th width="10%">File</th>
                                            <th width="20%">Nilai Capaian</th>
                                            <th width="40%">Deskripsi</th>
                                            <th width="20%">SKPD</th>
                                            <th width="10%">Aksi</th>
                                        @else
                                            <th width="10%">Gambar</th>
                                            <th width="20%">Nama Inovasi</th>
                                            <th width="40%">Deskripsi</th>
                                            <th width="20%">SKPD</th>
                                            <th width="10%">Aksi</th>
                                        @endif
                                    </tr>
                                    </thead>
                                    <tbody id="tabel-inovasi-body-{{ $item->KodePertanyaan }}">
                                        <!-- Data dari AJAX -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    <!-- Default JenisInput -->
                    @else
                        <div class="mb-3">
                            <label class="form-label">Capaian</label>
                            <select name="Capaian" class="form-select" required>
                                <option value="">-- Pilih Capaian --</option>
                                <option value="{{ $item->Pilihan1 }}" {{ $input && $input->Capaian == $item->Pilihan1 ? 'selected' : '' }}>{{ $item->Pilihan1 }}</option>
                                <option value="{{ $item->Pilihan2 }}" {{ $input && $input->Capaian == $item->Pilihan2 ? 'selected' : '' }}>{{ $item->Pilihan2 }}</option>
                            </select>
                        </div>
                    <!-- File Bukti Dukung -->
                    <div class="mb-3">
                        <label class="form-label">File Bukti Dukung</label>
                        <input type="file" name="FileBuktiDukung" class="form-control" {{ $input && $input->FileBukti ? '' : 'required' }}>
                        @if ($input && $input->FileBukti)
                            <small class="text-muted d-block mt-1">
                                File saat ini: 
                                <a href="{{ asset('storage/' . $input->FileBukti) }}" target="_blank">Lihat Bukti</a>
                            </small>
                        @endif
                    </div>

                    <!-- Keterangan -->
                    <div class="mb-3">
                        <label class="form-label">Keterangan</label>
                        <textarea name="Keterangan" class="form-control" rows="3">{{ $input->Keterangan ?? '' }}</textarea>
                    </div>
                    @endif
                </div>
                <div class="modal-footer">
                    @if ($item->JenisInput == 'JenisInput8')
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                    @else
                        <button type="submit" class="btn btn-primary">Simpan</button>
                        <!-- <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button> -->
                        <button type="button" class="btn-close" onclick="tutupModalUtama('{{ $modalId }}')"></button>
                    @endif
                </div>
            </form>
        </div>
<script>
document.addEventListener("DOMContentLoaded", function () {
    // 1. INISIALISASI modal utama & sub-modal
    document.querySelectorAll(".modal").forEach(function (modal) {
        modal.addEventListener("shown.bs.modal", function () {
            const kode = modal.id.replace("modalCapaian", "");
            const inputAtas = document.getElementById("inputAtas-" + kode);
            const inputBawah = document.getElementById("inputBawah-" + kode);
            const hasilCapaian = document.getElementById("hasilCapaian-" + kode);

            if (inputAtas && inputBawah && hasilCapaian) {
                function hitung() {
                    const a = parseFloat(inputAtas.value) || 0;
                    const b = parseFloat(inputBawah.value) || 0;
                    hasilCapaian.value = b > 0 ? ((a / b) * 100).toFixed(2) + "%" : "";
                }
                inputAtas.oninput = hitung;
                inputBawah.oninput = hitung;
                hitung();
            }

            const inputNilai = document.getElementById("inputNilai-" + kode);
            if (inputNilai && hasilCapaian) {
                function updateNilai() {
                    const val = parseFloat(inputNilai.value);
                    hasilCapaian.value = isNaN(val) ? '' : val;
                }
                inputNilai.oninput = updateNilai;
                updateNilai();
            }
        });
    });

    // 2. PASTIKAN backdrop bersih ketika semua modal ditutup
    document.addEventListener("hidden.bs.modal", function () {
        setTimeout(() => {
            if (!document.querySelector(".modal.show")) {
                document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
                document.body.classList.remove('modal-open');
                document.body.style.paddingRight = '';
            }
        }, 200); // tunggu animasi tutup selesai
    });
});

function bukaSubModalSetelahTutupModalUtama(idModalUtama, idModalSub) {
    const modalUtama = document.getElementById(idModalUtama);
    const modalSub = new bootstrap.Modal(document.getElementById(idModalSub));

    const bsModalUtama = bootstrap.Modal.getInstance(modalUtama);
    bsModalUtama.hide();

    // Saat modal utama sudah tertutup, buka modal sub
    modalUtama.addEventListener('hidden.bs.modal', function () {
        modalSub.show();

        // Saat modal sub ditutup, buka modal utama lagi
        const modalSubElement = document.getElementById(idModalSub);
        modalSubElement.addEventListener('hidden.bs.modal', function () {
            const kodePertanyaan = idModalSub.split('-')[1];
            const modalUtamaElement = document.getElementById(idModalUtama);

            // Tunggu modal utama selesai muncul, lalu reload daftar inovasi
            modalUtamaElement.addEventListener('shown.bs.modal', function handler() {
                reloadListInovasi(kodePertanyaan);
                modalUtamaElement.removeEventListener('shown.bs.modal', handler); // hanya sekali
            });

            const bsModalUtamaBaru = new bootstrap.Modal(modalUtamaElement);
            bsModalUtamaBaru.show();
        }, { once: true });
    }, { once: true });
}

// 4. Tutup sub modal dan kembali ke modal utama
function tutupSubModalDanKembali(modalSubId, modalUtamaId) {
    const subModalEl = document.getElementById(modalSubId);
    const subModal = bootstrap.Modal.getInstance(subModalEl);
    if (subModal) {
        subModal.hide();
        subModalEl.addEventListener('hidden.bs.modal', function listener() {
            subModalEl.removeEventListener('hidden.bs.modal', listener);
            const utamaEl = document.getElementById(modalUtamaId);
            const modalUtama = new bootstrap.Modal(utamaEl);
            modalUtama.show();
        });
    }
}

// 5. Tutup total modal utama (misal klik tombol close)
function tutupModalUtama(modalId) {
    const modalEl = document.getElementById(modalId);
    const modal = bootstrap.Modal.getInstance(modalEl);
    if (modal) {
        modal.hide();
    }
}

function loadInovasi(kodePertanyaan) {
    fetch(`/otda/inovasi/${kodePertanyaan}/list`)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const target = document.querySelector(`#tabel-inovasi-body-${kodePertanyaan}`);
                if (target) {
                    target.innerHTML = data.html;
                }
            } else {
                alert("Gagal mengambil data: " + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
}
function hapusInovasi(id, kodePertanyaan) {
    if (!kodePertanyaan) {
        console.error('kodePertanyaan tidak ada!');
        return;
    }

    // Lanjutkan request Hapus
    fetch(`/otda/inovasi/${id}`, {
        method: 'DELETE',
        headers: {
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
    })
    .then(res => res.json())
    .then(res => {
        if (res.success) {
            toastr.success(res.message || 'Data berhasil dihapus.');
            reloadListInovasi(kodePertanyaan);
        } else {
            toastr.error(res.message || 'Data gagal dihapus.');
        }
    })
    .catch(err => {
        console.error(err);
        // alert('Terjadi kesalahan saat menghapus');
        toastr.error('Terjadi kesalahan saat menghapus' + error);
    });
}

function reloadListInovasi(kodePertanyaan) {
    fetch(`/otda/inovasi/${kodePertanyaan}/list`)
        .then(response => response.json())
        .then(data => {
            const tbody = document.getElementById(`tabel-inovasi-body-${kodePertanyaan}`);
            if (!tbody) {
                console.error(`#tabel-inovasi-body-${kodePertanyaan} tidak ditemukan!`);
                return;
            }
            tbody.innerHTML = data.html;
            console.log('tbody:', tbody);

            if (data.success) {
                if (tbody) {
                    tbody.innerHTML = data.html;
                    toastr.success('Daftar inovasi diperbarui.');
                } else {
                    console.warn(`#tabel-inovasi-body-${kodePertanyaan} tidak ditemukan!`);
                }
            } else {
                toastr.error('Gagal memuat daftar inovasi.');
            }
        })
        .catch(error => {
            console.error(error);
            toastr.error('Terjadi kesalahan saat memuat daftar inovasi.');
        });
}

</script>
    </div>
<!-- Modal Tambah Inovasi -->
<div class="modal fade" id="modalTambahData-{{ $item->KodePertanyaan }}" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Tambah Data Inovasi</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <form id="formTambahInovasi-{{ $item->KodePertanyaan }}" onsubmit="return false;">
          <meta name="csrf-token" content="{{ csrf_token() }}">
          <div class="row mb-3">
            <div class="col-md-6">
              <label class="form-label">
                @if ($item->KodePertanyaan === 'EKPD007')
                    File
                @else
                    Gambar
                @endif
              </label>
              <input type="file" class="form-control" name="Gambar" accept="image/*,.pdf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.txt">
            </div>
            <div class="col-md-6">
              <label class="form-label">
                @if ($item->KodePertanyaan === 'EKPD007')
                    Nilai Capaian
                @else
                    Nama Inovasi
                @endif
              </label>
              <input type="text" class="form-control" name="Nama" required>
            </div>
          </div>
          <div class="mb-3">
            <label class="form-label">Deskripsi</label>
            <textarea class="form-control" name="Deskripsi" required></textarea>
          </div>
          <div class="mb-3">
            <label class="form-label">SKPD</label>
            <input type="text" class="form-control" name="SKPD" required>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <!-- <button type="submit" class="btn btn-primary">Simpan</button> -->
        <button type="button" class="btn btn-primary" onclick="tambahDataInovasi('{{ $item->KodePertanyaan }}')">Simpan</button>
        
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
      </div>
      <script>
function tambahDataInovasi(kodePertanyaan) {
    const form = document.getElementById(`formTambahInovasi-${kodePertanyaan}`);
    const formData = new FormData(form);

    fetch(`/otda/inovasi/${kodePertanyaan}`, {
        method: 'POST',
        headers: {
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: formData
    })
    .then(async (response) => {
        if (!response.ok) {
            const text = await response.text();
            throw new Error(`HTTP ${response.status}: ${text}`);
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            // Ambil data dari form
            const nama = form.querySelector('[name="Nama"]').value;
            const deskripsi = form.querySelector('[name="Deskripsi"]').value;
            const skpd = form.querySelector('[name="SKPD"]').value;
            const fileUpload = form.querySelector('[name="Gambar"]').files[0];

            const tabelBody = document.querySelector(`#tabel-inovasi-body-${kodePertanyaan}`);
            const tr = document.createElement('tr');

            // Default kalau tidak ada file
            let fileTd = '<td>Tidak ada file</td>';

            if (fileUpload) {
                const fileURL = URL.createObjectURL(fileUpload);
                const fileType = fileUpload.type;
                const fileName = fileUpload.name.toLowerCase();

                if (fileType.startsWith("image/")) {
                    fileTd = `<td><img src="${fileURL}" alt="Gambar Inovasi" width="80"></td>`;
                } else if (fileType === "application/pdf") {
                    fileTd = `<td><a href="${fileURL}" target="_blank">📄 Lihat PDF</a></td>`;
                } else if (fileName.endsWith(".doc") || fileName.endsWith(".docx")) {
                    fileTd = `<td><a href="${fileURL}" target="_blank">📝 Lihat Word</a></td>`;
                } else if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                    fileTd = `<td><a href="${fileURL}" target="_blank">📊 Lihat Excel</a></td>`;
                } else if (fileName.endsWith(".ppt") || fileName.endsWith(".pptx")) {
                    fileTd = `<td><a href="${fileURL}" target="_blank">📑 Lihat PowerPoint</a></td>`;
                } else {
                    fileTd = `<td><a href="${fileURL}" target="_blank">📎 Lihat File</a></td>`;
                }
            }

            tr.innerHTML = `
                ${fileTd}
                <td>${nama}</td>
                <td>${deskripsi}</td>
                <td>${skpd}</td>
            `;

            tabelBody.appendChild(tr);

            // Tutup modal
            const modal = bootstrap.Modal.getInstance(document.getElementById(`modalTambahData-${kodePertanyaan}`));
            modal.hide();

            // Reset form
            form.reset();

            // Tampilkan kembali modal utama
            const modalUtamaId = `modalCapaian${kodePertanyaan}`;
            const modalUtamaEl = document.getElementById(modalUtamaId);
            const modalUtamaInstance = bootstrap.Modal.getInstance(modalUtamaEl) || new bootstrap.Modal(modalUtamaEl);
            modalUtamaInstance.show();

            // Refresh ulang data tabel dari server
            fetch(`/otda/inovasi/${kodePertanyaan}/list`)
                .then(res => res.json())
                .then(res => {
                    const tabelBody = document.querySelector(`#tabel-inovasi-body-${kodePertanyaan}`);
                    tabelBody.innerHTML = res.html;
                });

            toastr.success('Data berhasil ditambah.');
        } else {
            toastr.error('Gagal menyimpan data.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        toastr.error('Terjadi kesalahan: ' + error);
    });
}

</script>
    </div>
  </div>
</div>
@endforeach


</div>
@endsection




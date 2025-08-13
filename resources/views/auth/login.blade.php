<x-guest-layout>
    <!-- Session Status -->
    <x-auth-session-status class="mb-4" :status="session('status')" />

    <form method="POST" action="{{ route('login') }}">
        @csrf

        <!-- OPD Dropdown -->
            <div>
                <label for="opd" class="block font-medium text-sm text-gray-700">Pilih OPD</label>
                <select id="opd" name="opd" required autofocus class="mt-1 block w-full">
                    <option value="">-- Pilih OPD --</option>
                    <option value="HUKUM">HUKUM</option>
                    <option value="ORGANISASI">ORGANISASI</option>
                    <option value="PEMERINTAHAN">PEMERINTAHAN</option>
                    <option value="BKD">BKD</option>
                    <option value="BKPSDM">BKPSDM</option>
                    <option value="DINKES">DINKES</option>
                    <option value="DPMPTSP">DPMPTSP</option>
                    <option value="INSPEKTORAT">INSPEKTORAT</option>
                    <option value="SATPOLPP">SATPOLPP</option>
                    <option value="DISDUKCAPIL">DISDUKCAPIL</option>
                    <option value="DPUPR">DPUPR</option>
                    <option value="BPBD">BPBD</option>
                    <option value="DISDAGPERINAKER">DISDAGPERINAKER</option>
                    <option value="DP3APPKB">DP3APPKB</option>
                    <option value="DISKUKTRANS ESDM">DISKUKTRANS ESDM</option>
                    <option value="DISPARPORA">DISPARPORA</option>
                    <option value="DISDIKBUD">DISDIKBUD</option>
                    <option value="BAPERLITBANG">BAPERLITBANG</option>
                    <option value="PEREKONOMIAN">PEREKONOMIAN</option>
                    <option value="DISPERTAN PP">DISPERTAN PP</option>
                    <option value="DISKOMINFO">DISKOMINFO</option>
                    <option value="DINSOS">DINSOS</option>
                    <option value="BAKESBANGPOL">BAKESBANGPOL</option>
                </select>
            </div>
            <div>
                <label for="tahun" class="block font-medium text-sm text-gray-700">Pilih Tahun</label>
                <select id="tahun" name="tahun" required autofocus class="mt-1 block w-full">
                    <option value="">-- Pilih Tahun --</option>
                    <option value="2024">2024</option>
                </select>
            </div>
<script>
    // Ambil tahun sekarang dari sistem
    const currentYear = (new Date().getFullYear() - 1).toString(); // Misalnya 2024
    const select = document.getElementById('tahun');

    // Cek apakah tahun saat ini ada di dalam <option>, jika ada set sebagai selected
    const option = [...select.options].find(opt => opt.value == currentYear);
    if (option) {
        option.selected = true;
    }
</script>
        <!-- Email Address -->
        <!-- <div>
            <x-input-label for="email" :value="__('Email')" />
            <x-text-input id="email" class="block mt-1 w-full" type="email" name="email" :value="old('email')" required autofocus autocomplete="username" />
            <x-input-error :messages="$errors->get('email')" class="mt-2" />
        </div> -->

        <!-- Password -->
        <!-- <div class="mt-4">
            <x-input-label for="password" :value="__('Password')" />

            <x-text-input id="password" class="block mt-1 w-full"
                            type="password"
                            name="password"
                            required autocomplete="current-password" />

            <x-input-error :messages="$errors->get('password')" class="mt-2" />
        </div> -->

        <!-- Remember Me -->
        <!-- <div class="block mt-4">
            <label for="remember_me" class="inline-flex items-center">
                <input id="remember_me" type="checkbox" class="rounded border-gray-300 text-indigo-600 shadow-sm focus:ring-indigo-500" name="remember">
                <span class="ms-2 text-sm text-gray-600">{{ __('Remember me') }}</span>
            </label>
        </div> -->

        <div class="flex items-center justify-end mt-4">
            <!-- @if (Route::has('password.request'))
                <a class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" href="{{ route('password.request') }}">
                    {{ __('Forgot your password?') }}
                </a>
            @endif -->

            <x-primary-button class="ms-3">
                {{ __('Log in') }}
            </x-primary-button>
        </div>
    </form>
</x-guest-layout>

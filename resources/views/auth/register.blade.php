<x-guest-layout>
    <form method="POST" action="{{ route('register') }}">
        @csrf

        <!-- Name -->
        <div>
            <x-input-label for="name" :value="__('Name')" />
            <x-text-input id="name" class="block mt-1 w-full" type="text" name="name" :value="old('name')" required autofocus autocomplete="name" />
            <x-input-error :messages="$errors->get('name')" class="mt-2" />
        </div>

        <!-- OPD -->
        <div>
            <label for="opd" class="block text-sm font-medium text-gray-700">OPD</label>
            <select name="opd" id="opd" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
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

        <!-- Email Address -->
        <div class="mt-4">
            <x-input-label for="email" :value="__('Email')" />
            <x-text-input id="email" class="block mt-1 w-full" type="email" name="email" :value="old('email')" required autocomplete="username" />
            <x-input-error :messages="$errors->get('email')" class="mt-2" />
        </div>

        <!-- Password -->
        <div class="mt-4">
            <x-input-label for="password" :value="__('Password')" />

            <x-text-input id="password" class="block mt-1 w-full"
                            type="password"
                            name="password"
                            required autocomplete="new-password" />

            <x-input-error :messages="$errors->get('password')" class="mt-2" />
        </div>

        <!-- Confirm Password -->
        <div class="mt-4">
            <x-input-label for="password_confirmation" :value="__('Confirm Password')" />

            <x-text-input id="password_confirmation" class="block mt-1 w-full"
                            type="password"
                            name="password_confirmation" required autocomplete="new-password" />

            <x-input-error :messages="$errors->get('password_confirmation')" class="mt-2" />
        </div>

        <div class="flex items-center justify-end mt-4">
            <a class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" href="{{ route('login') }}">
                {{ __('Already registered?') }}
            </a>

            <x-primary-button class="ms-4">
                {{ __('Register') }}
            </x-primary-button>
        </div>
    </form>
</x-guest-layout>

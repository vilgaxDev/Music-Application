<?php

namespace App\installer\Controllers;

use Illuminate\Routing\Controller;
use App\installer\Events\LaravelInstallerFinished;
use App\installer\Helpers\EnvironmentManager;
use App\installer\Helpers\FinalInstallManager;
use App\installer\Helpers\InstalledFileManager;

class FinalController extends Controller
{
    /**
     * Update installed file and display finished view.
     *
     * @param \App\installer\Helpers\InstalledFileManager $fileManager
     * @param \App\installer\Helpers\FinalInstallManager $finalInstall
     * @param \App\installer\Helpers\EnvironmentManager $environment
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function finish(InstalledFileManager $fileManager, FinalInstallManager $finalInstall, EnvironmentManager $environment)
    {
        $finalMessages = $finalInstall->runFinal();
        $finalStatusMessage = $fileManager->update();
        $finalEnvFile = $environment->getEnvContent();

        event(new LaravelInstallerFinished);

        return view('vendor.installer.finished', compact('finalMessages', 'finalStatusMessage', 'finalEnvFile'));
    }
}

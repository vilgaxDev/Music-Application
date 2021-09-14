<?php

namespace App\installer\Controllers;

use Illuminate\Routing\Controller;
use Illuminate\Http\Request;
use App\installer\Helpers\DatabaseManager;

class DatabaseController extends Controller
{
    /**
     * @var DatabaseManager
     */
    private $databaseManager;
    /**
     * @param DatabaseManager $databaseManager
     */
    public function __construct(DatabaseManager $databaseManager)
    {
        $this->databaseManager = $databaseManager;
    }
    /**
     * Migrate and seed the database.
     *
     * @return \Illuminate\View\View
     */
    public function database($request)
    {
        return $this->databaseManager->migrateAndSeed($request);
    }
    /**
     * Display the create admin form page.
     *
     * @return \Illuminate\View\View
     */
    public function createAdminPage()
    {
        return view('vendor.installer.create-admin');
    }
    /**
     * Validate the super-admin account data submitted by the form.
     */
    public function validateSuperAdminData(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email|max:255',
            'password' => 'required|confirmed|string|min:8',
        ]);
        return $this->database($request);
    }
}

<?php

namespace Database\Seeders;
use App\Models\Role;
use Illuminate\Database\Seeder;

class RolesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $role = new Role();
        $role->name = 'Editorial design manager';
        $role->description = 'Editorial design manager';
        $role->key = Role::ROLE_EDITORIAL_DESIGN_MANAGER;
        $role->save();

        $role = new Role();
        $role->name = 'Editorial project manager';
        $role->description = 'Editorial project manager';
        $role->key = Role::ROLE_EDITORIAL_PROJECT_MANAGER;
        $role->save();

        $role = new Role();
        $role->name = 'Sales manager';
        $role->description = 'Sales manager';
        $role->key = Role::ROLE_SALES_MANAGER;
        $role->save();

        $role = new Role();
        $role->name = 'Adv manager';
        $role->description = 'Adv manager';
        $role->key = Role::ROLE_ADV_MANAGER;
        $role->save();

        $role = new Role();
        $role->name = 'CEO';
        $role->description = 'CEO';
        $role->key = Role::ROLE_CEO;
        $role->save();

        $role = new Role();
        $role->name = 'Admin';
        $role->description = 'Admin';
        $role->key = Role::ROLE_ADMIN;
        $role->save();
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Role extends Model
{
    use HasFactory;
    CONST ROLE_EDITORIAL_DESIGN_MANAGER = 'editorial-design-manager';
    CONST ROLE_EDITORIAL_PROJECT_MANAGER = 'editorial-project-manager';
    CONST ROLE_ADV_MANAGER = 'adv-manager';
    CONST ROLE_SALES_MANAGER = 'sales-manager';
    CONST ROLE_CEO = 'ceo';
    CONST ROLE_ADMIN = 'admin';
    protected $table = 'roles';

    public function users(): BelongsToMany {

      return $this->belongsToMany(User::class, 'user_role');

    }


}

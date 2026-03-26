<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Course extends Model {
    protected $fillable = ['code', 'title', 'description'];

    public function students(){
        return $this->belongsToMany(Student::class)->withTimestamps();
    }

    public function grades(){
        return $this->hasMany(Grade::class);
    }
}

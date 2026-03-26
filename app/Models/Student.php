<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Student extends Model {
    protected $fillable = ['student_number', 'name', 'email', 'major'];

    public function courses(){
        return $this->belongsToMany(Course::class)->withTimestamps();
    }

    public function grades(){
        return $this->hasMany(Grade::class);
    }

    public function submissions(){
        return $this->hasMany(Submission::class);
    }
}

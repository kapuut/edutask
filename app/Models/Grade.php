<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Grade extends Model {
    protected $fillable = ['student_id', 'course_id', 'scores', 'feedback', 'final_score'];

    protected $casts = [
        'scores' => 'array',
        'feedback' => 'array',
        'final_score' => 'float',
    ];

    public function student(){
        return $this->belongsTo(Student::class);
    }

    public function course(){
        return $this->belongsTo(Course::class);
    }
}

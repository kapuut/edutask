<?php

namespace App\Http\Controllers;

use App\Models\Student;

class ReportController extends Controller
{
    public function studentPerformance(Student $student)
    {
        $student->load(['grades.course']);

        $grades = $student->grades->map(function ($grade) {
            return [
                'course' => $grade->course?->title,
                'course_code' => $grade->course?->code,
                'scores' => $grade->scores,
                'feedback_tuple' => $grade->feedback,
                'final_score' => $grade->final_score,
            ];
        })->values();

        $average = $grades->count() > 0
            ? round($grades->avg('final_score'), 2)
            : 0;

        $status = match (true) {
            $average >= 85 => 'Excellent',
            $average >= 70 => 'Good',
            $average >= 60 => 'Fair',
            default => 'Needs Improvement',
        };

        return response()->json([
            'student' => [
                'id' => $student->id,
                'student_number' => $student->student_number,
                'name' => $student->name,
                'email' => $student->email,
                'major' => $student->major,
            ],
            'summary' => [
                'average_final_score' => $average,
                'performance_status' => $status,
                'courses_taken' => $grades->count(),
            ],
            'grades' => $grades,
        ]);
    }
}

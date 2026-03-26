<?php

namespace App\Http\Controllers;

use App\Models\Submission;
use App\Models\Student;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class SubmissionController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'student_id' => ['required', 'integer', Rule::exists('students', 'id')],
            'course_id' => ['required', 'integer', Rule::exists('courses', 'id')],
            'task_name' => ['required', 'string', 'max:150'],
            'assignment_file' => ['required', 'file', 'max:5120', 'mimes:pdf,doc,docx,txt,zip'],
        ]);

        $storedPath = $request->file('assignment_file')->store('submissions', 'public');

        $submission = Submission::create([
            'student_id' => $validated['student_id'],
            'course_id' => $validated['course_id'],
            'task_name' => $validated['task_name'],
            'file_path' => $storedPath,
            'original_file_name' => $request->file('assignment_file')->getClientOriginalName(),
        ]);

        return response()->json($submission->fresh(['student', 'course']), 201);
    }

    public function studentSubmissions(Student $student)
    {
        return response()->json(
            $student->submissions()->with('course')->latest()->get()
        );
    }
}

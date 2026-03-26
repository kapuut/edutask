<?php
namespace App\Http\Controllers;

use App\Models\Course;
use App\Models\Student;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class StudentController extends Controller {

    public function index(){
        return response()->json(
            Student::query()
                ->with(['courses', 'grades'])
                ->orderBy('name')
                ->get()
        );
    }

    public function store(Request $request){
        $validated = $request->validate([
            'student_number' => ['required', 'string', 'max:50', 'unique:students,student_number'],
            'name' => ['required', 'string', 'max:150'],
            'email' => ['required', 'email', 'max:150', 'unique:students,email'],
            'major' => ['nullable', 'string', 'max:120'],
        ]);

        return response()->json(Student::create($validated), 201);
    }

    public function update(Request $request, Student $student){
        $validated = $request->validate([
            'student_number' => [
                'required',
                'string',
                'max:50',
                Rule::unique('students', 'student_number')->ignore($student->id),
            ],
            'name' => ['required', 'string', 'max:150'],
            'email' => ['required', 'email', 'max:150', Rule::unique('students', 'email')->ignore($student->id)],
            'major' => ['nullable', 'string', 'max:120'],
        ]);

        $student->update($validated);

        return response()->json($student->fresh(['courses', 'grades']));
    }

    public function destroy(Student $student){
        $student->delete();

        return response()->json(['message' => 'Student deleted']);
    }

    public function assignCourse(Request $request, Student $student){
        $validated = $request->validate([
            'course_ids' => ['required', 'array', 'min:1'],
            'course_ids.*' => ['required', 'integer', Rule::exists('courses', 'id')],
            'mode' => ['nullable', Rule::in(['sync', 'attach'])],
        ]);

        $courseIds = Course::query()->whereIn('id', $validated['course_ids'])->pluck('id')->all();
        $mode = $validated['mode'] ?? 'sync';

        if ($mode === 'attach') {
            $student->courses()->syncWithoutDetaching($courseIds);
        } else {
            $student->courses()->sync($courseIds);
        }

        return response()->json($student->fresh('courses'));
    }
}

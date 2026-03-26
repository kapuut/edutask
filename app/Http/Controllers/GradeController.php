<?php

namespace App\Http\Controllers;

use App\Models\Grade;
use App\Services\Validation\EduTrackInputValidator;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class GradeController extends Controller
{
    public function __construct(private readonly EduTrackInputValidator $validator)
    {
    }

    public function index()
    {
        return response()->json(
            Grade::query()->with(['student', 'course'])->orderByDesc('id')->get()
        );
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'student_id' => ['required', 'integer', Rule::exists('students', 'id')],
            'course_id' => ['required', 'integer', Rule::exists('courses', 'id')],
            'scores' => ['required', 'array', 'min:1'],
            'scores.*' => ['required'],
            'feedback' => ['nullable', 'array'],
            'feedback.*' => ['string'],
        ]);

        $payload = $this->validator->validateScorePayload($validated['scores']);

        if (isset($validated['feedback']) && $validated['feedback'] !== []) {
            $payload['feedback'] = [
                (string) ($validated['feedback'][0] ?? 'No comment'),
                (string) ($validated['feedback'][1] ?? 'Reviewed by admin'),
            ];
        }

        $grade = Grade::query()->updateOrCreate(
            [
                'student_id' => $validated['student_id'],
                'course_id' => $validated['course_id'],
            ],
            $payload
        );

        return response()->json($grade->fresh(['student', 'course']));
    }

    public function update(Request $request, Grade $grade)
    {
        $validated = $request->validate([
            'scores' => ['required', 'array', 'min:1'],
            'scores.*' => ['required'],
            'feedback' => ['nullable', 'array'],
            'feedback.*' => ['string'],
        ]);

        $payload = $this->validator->validateScorePayload($validated['scores']);

        if (isset($validated['feedback']) && $validated['feedback'] !== []) {
            $payload['feedback'] = [
                (string) ($validated['feedback'][0] ?? 'No comment'),
                (string) ($validated['feedback'][1] ?? 'Reviewed by admin'),
            ];
        }

        $grade->update($payload);

        return response()->json($grade->fresh(['student', 'course']));
    }
}

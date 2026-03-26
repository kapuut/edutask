<?php

namespace Tests\Feature;

use App\Models\Admin;
use App\Models\Course;
use App\Models\Student;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class EduTrackFeatureTest extends TestCase
{
    use RefreshDatabase;

    private function adminSession(): array
    {
        $admin = Admin::query()->create([
            'username' => 'admin',
            'password' => Hash::make('admin123'),
        ]);

        return [
            'admin_id' => $admin->id,
            'admin_username' => $admin->username,
        ];
    }

    public function test_protected_route_requires_login(): void
    {
        $this->getJson('/dashboard')->assertStatus(401);
    }

    public function test_can_create_student_and_assign_course_and_store_grade(): void
    {
        $session = $this->adminSession();

        $studentResponse = $this->withSession($session)->postJson('/students', [
            'student_number' => 'STU-001',
            'name' => 'Ari Saputra',
            'email' => 'ari@example.com',
            'major' => 'Informatika',
        ])->assertCreated();

        $courseResponse = $this->withSession($session)->postJson('/courses', [
            'code' => 'CS101',
            'title' => 'Dasar Pemrograman',
            'description' => 'Belajar konsep dasar',
        ])->assertCreated();

        $studentId = $studentResponse->json('id');
        $courseId = $courseResponse->json('id');

        $this->withSession($session)
            ->postJson("/students/{$studentId}/assign-course", [
                'course_ids' => [$courseId],
                'mode' => 'sync',
            ])
            ->assertOk()
            ->assertJsonPath('courses.0.id', $courseId);

        $this->withSession($session)
            ->postJson('/grades', [
                'student_id' => $studentId,
                'course_id' => $courseId,
                'scores' => [80, 85, 90],
                'feedback' => ['Bagus', 'Perlu lebih konsisten'],
            ])
            ->assertOk()
            ->assertJsonPath('final_score', 85.0);

        $this->withSession($session)
            ->getJson("/reports/students/{$studentId}")
            ->assertOk()
            ->assertJsonPath('summary.average_final_score', 85.0);
    }

    public function test_can_upload_assignment_file(): void
    {
        Storage::fake('public');
        $session = $this->adminSession();

        $student = Student::query()->create([
            'student_number' => 'STU-002',
            'name' => 'Budi',
            'email' => 'budi@example.com',
            'major' => 'Sistem Informasi',
        ]);

        $course = Course::query()->create([
            'code' => 'DB201',
            'title' => 'Basis Data',
            'description' => 'Relasional dan SQL',
        ]);

        $file = UploadedFile::fake()->create('tugas1.pdf', 100, 'application/pdf');

        $response = $this->withSession($session)
            ->post('/submissions', [
                'student_id' => $student->id,
                'course_id' => $course->id,
                'task_name' => 'Tugas Minggu 1',
                'assignment_file' => $file,
            ], ['Accept' => 'application/json']);

        $response->assertCreated();
        Storage::disk('public')->assertExists($response->json('file_path'));
    }
}

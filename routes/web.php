
<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminAuthController;
use App\Http\Controllers\CourseController;
use App\Http\Controllers\GradeController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\StudentController;
use App\Http\Controllers\SubmissionController;
use App\Http\Middleware\AdminAuthMiddleware;

Route::get('/login', [AdminAuthController::class, 'showLogin'])->name('login');
Route::post('/login', [AdminAuthController::class, 'login'])->name('admin.login.submit');
Route::post('/logout', [AdminAuthController::class, 'logout'])->name('admin.logout');

Route::middleware([AdminAuthMiddleware::class])->group(function () {
	Route::get('/dashboard', [AdminAuthController::class, 'dashboard'])->name('admin.dashboard');

	Route::get('/students', [StudentController::class, 'index'])->name('students.index');
	Route::post('/students', [StudentController::class, 'store'])->name('students.store');
	Route::put('/students/{student}', [StudentController::class, 'update'])->name('students.update');
	Route::delete('/students/{student}', [StudentController::class, 'destroy'])->name('students.destroy');
	Route::post('/students/{student}/assign-course', [StudentController::class, 'assignCourse'])->name('students.assign-course');

	Route::get('/courses', [CourseController::class, 'index'])->name('courses.index');
	Route::post('/courses', [CourseController::class, 'store'])->name('courses.store');
	Route::put('/courses/{course}', [CourseController::class, 'update'])->name('courses.update');
	Route::delete('/courses/{course}', [CourseController::class, 'destroy'])->name('courses.destroy');

	Route::get('/grades', [GradeController::class, 'index'])->name('grades.index');
	Route::post('/grades', [GradeController::class, 'store'])->name('grades.store');
	Route::put('/grades/{grade}', [GradeController::class, 'update'])->name('grades.update');

	Route::post('/submissions', [SubmissionController::class, 'store'])->name('submissions.store');
	Route::get('/submissions/student/{student}', [SubmissionController::class, 'studentSubmissions'])->name('submissions.student');

	Route::get('/reports/students/{student}', [ReportController::class, 'studentPerformance'])->name('reports.student.performance');
});

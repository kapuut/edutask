<?php

namespace Tests\Unit;

use App\Services\Validation\EduTrackInputValidator;
use InvalidArgumentException;
use PHPUnit\Framework\TestCase;

class EduTrackInputValidatorTest extends TestCase
{
    public function test_validate_score_payload_with_array(): void
    {
        $validator = new EduTrackInputValidator();
        $result = $validator->validateScorePayload([80, 90, 100]);

        $this->assertSame([80.0, 90.0, 100.0], $result['scores']);
        $this->assertSame(90.0, $result['final_score']);
        $this->assertIsArray($result['feedback']);
        $this->assertCount(2, $result['feedback']);
    }

    public function test_validate_score_payload_with_tuple_like_params(): void
    {
        $validator = new EduTrackInputValidator();
        $result = $validator->validateScorePayload(88, 'Great job');

        $this->assertSame([88.0], $result['scores']);
        $this->assertSame(88.0, $result['final_score']);
        $this->assertSame('Great job', $result['feedback'][0]);
    }

    public function test_validate_score_payload_throws_on_invalid_score(): void
    {
        $this->expectException(InvalidArgumentException::class);

        $validator = new EduTrackInputValidator();
        $validator->validateScorePayload([120]);
    }
}

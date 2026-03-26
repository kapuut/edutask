<?php

namespace App\Services\Validation;

use InvalidArgumentException;

class EduTrackInputValidator extends BaseInputValidator
{
    /**
     * Function overloading simulation with variadic args:
     * - validateScorePayload(array $scores)
     * - validateScorePayload(float|int $score, string $comment)
     */
    public function validateScorePayload(mixed ...$args): array
    {
        if (count($args) === 1 && is_array($args[0])) {
            $scores = $args[0];
            $feedback = ['Generated from scores'];
        } elseif (count($args) === 2) {
            $scores = [$args[0]];
            $feedback = [$args[1]];
        } else {
            throw new InvalidArgumentException('Invalid score payload format.');
        }

        if ($scores === []) {
            throw new InvalidArgumentException('Scores cannot be empty.');
        }

        $cleanScores = [];

        foreach ($scores as $score) {
            $numericScore = $this->normalizeScore($score);

            switch (true) {
                case $numericScore < 0:
                    throw new InvalidArgumentException('Score must be numeric.');
                case $numericScore > 100:
                    throw new InvalidArgumentException('Score cannot be greater than 100.');
                default:
                    $cleanScores[] = $numericScore;
            }
        }

        $tupleFeedback = [
            (string) ($feedback[0] ?? 'No comment'),
            (string) ($feedback[1] ?? 'Reviewed by system'),
        ];

        return [
            'scores' => $cleanScores,
            'feedback' => $tupleFeedback,
            'final_score' => round(array_sum($cleanScores) / count($cleanScores), 2),
        ];
    }
}

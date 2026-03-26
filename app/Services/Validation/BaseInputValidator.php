<?php

namespace App\Services\Validation;

class BaseInputValidator
{
    protected function normalizeScore(mixed $score): float
    {
        return is_numeric($score) ? (float) $score : -1;
    }
}

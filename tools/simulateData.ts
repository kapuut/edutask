type ScoreTuple = [number, string];

interface StudentSimulation {
  studentNumber: string;
  name: string;
  major: string;
  scores: number[];
  feedback: ScoreTuple;
}

const sampleStudents: StudentSimulation[] = [
  {
    studentNumber: "STU-001",
    name: "Ari Saputra",
    major: "Informatika",
    scores: [80, 85, 90],
    feedback: [85, "Progress bagus"],
  },
  {
    studentNumber: "STU-002",
    name: "Budi Hartono",
    major: "Sistem Informasi",
    scores: [72, 78, 74],
    feedback: [75, "Perlu latihan tambahan"],
  },
];

function calculateAverage(scores: number[]): number {
  if (scores.length === 0) {
    return 0;
  }

  return Number((scores.reduce((sum, score) => sum + score, 0) / scores.length).toFixed(2));
}

function performanceLabel(avg: number): string {
  switch (true) {
    case avg >= 85:
      return "Excellent";
    case avg >= 70:
      return "Good";
    case avg >= 60:
      return "Fair";
    default:
      return "Needs Improvement";
  }
}

const report = sampleStudents.map((student) => {
  const average = calculateAverage(student.scores);

  return {
    studentNumber: student.studentNumber,
    name: student.name,
    average,
    status: performanceLabel(average),
    comment: student.feedback[1],
  };
});

console.log("EduTrack TypeScript Simulation");
console.table(report);

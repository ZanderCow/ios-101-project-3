import Foundation

class TriviaQuestion {
    let question: String
    let topic: String
    let answers: [String]
    let correctAnswerIndex: Int

    var correctAnswer: String {
        answers[correctAnswerIndex]
    }

    init(question: String, topic: String, answers: [String], correctAnswerIndex: Int) {
        precondition(answers.count == 4, "TriviaQuestion requires exactly 4 answers.")
        precondition((0..<answers.count).contains(correctAnswerIndex), "correctAnswerIndex must point to one of the 4 answers.")
        self.question = question
        self.topic = topic
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }

    static let sampleQuestions: [TriviaQuestion] = [
        TriviaQuestion(
            question: "What was the first weapon pack for PAYDAY 2?",
            topic: "Entertainment: Video Games",
            answers: ["The Overkill Pack", "The Gage Weapon Pack #1", "The Gage Chivalry Pack", "The Gage Historical Pack"],
            correctAnswerIndex: 1
        ),
        TriviaQuestion(
            question: "Which planet is known as the Red Planet?",
            topic: "Science",
            answers: ["Venus", "Mars", "Jupiter", "Mercury"],
            correctAnswerIndex: 1
        ),
        TriviaQuestion(
            question: "Who wrote the novel 1984?",
            topic: "Literature",
            answers: ["George Orwell", "Aldous Huxley", "Ray Bradbury", "Jules Verne"],
            correctAnswerIndex: 0
        ),
        TriviaQuestion(
            question: "What is the capital city of Canada?",
            topic: "Geography",
            answers: ["Toronto", "Vancouver", "Ottawa", "Montreal"],
            correctAnswerIndex: 2
        ),
        TriviaQuestion(
            question: "How many players are on the court for one basketball team during play?",
            topic: "Sports",
            answers: ["4", "5", "6", "7"],
            correctAnswerIndex: 1
        ),
        TriviaQuestion(
            question: "What does HTTP stand for?",
            topic: "Technology",
            answers: ["HyperText Transfer Protocol", "High Transfer Text Process", "Hyper Terminal Trace Program", "Host Transfer Type Protocol"],
            correctAnswerIndex: 0
        ),
        TriviaQuestion(
            question: "Which artist released the album Thriller?",
            topic: "Music",
            answers: ["Prince", "Madonna", "Michael Jackson", "Whitney Houston"],
            correctAnswerIndex: 2
        ),
        TriviaQuestion(
            question: "What is the largest ocean on Earth?",
            topic: "Geography",
            answers: ["Atlantic Ocean", "Indian Ocean", "Arctic Ocean", "Pacific Ocean"],
            correctAnswerIndex: 3
        ),
        TriviaQuestion(
            question: "What year did the first iPhone launch?",
            topic: "Technology",
            answers: ["2005", "2007", "2009", "2010"],
            correctAnswerIndex: 1
        ),
        TriviaQuestion(
            question: "Which gas do plants absorb from the atmosphere?",
            topic: "Science",
            answers: ["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"],
            correctAnswerIndex: 2
        )
    ]
}

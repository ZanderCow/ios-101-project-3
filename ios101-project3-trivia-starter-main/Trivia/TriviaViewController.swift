//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Zander Cowan on 2/18/26.
//

import UIKit

class TriviaViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionCardView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!

    private let questionsPerRound = 5
    private var currentRoundQuestions: [TriviaQuestion] = []
    private var currentQuestionIndex = 0
    private var score = 0

    private var answerButtons: [UIButton] {
        [answerButton1, answerButton2, answerButton3, answerButton4]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnswerButtons()
        startNewRound()
    }

    private func configureAnswerButtons() {

        // map buttons to their index for easy identification when tapped
        for (index, button) in answerButtons.enumerated() {
            button.tag = index
            button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        }
    }

    private func startNewRound() {
        score = 0
        currentQuestionIndex = 0

        let shuffledQuestions = TriviaQuestion.sampleQuestions.shuffled()
        let questionCount = min(questionsPerRound, shuffledQuestions.count)
        currentRoundQuestions = Array(shuffledQuestions.prefix(questionCount))
       
        // edge case - if there are no questions available, show a message instead of trying to render a question
        guard !currentRoundQuestions.isEmpty else {
            questionNumberLabel.text = "Question: 0/0"
            categoryLabel.text = "No Topic"
            questionLabel.text = "No questions available."
            setAnswerButtonsEnabled(false)
            return
        }

        renderCurrentQuestion()
    }

    private func renderCurrentQuestion() {
        let currentQuestion = currentRoundQuestions[currentQuestionIndex]

        questionNumberLabel.text = "Question: \(currentQuestionIndex + 1)/\(currentRoundQuestions.count)"
        categoryLabel.text = currentQuestion.topic
        questionLabel.text = currentQuestion.question

        for (index, button) in answerButtons.enumerated() {
            setButtonTitle(currentQuestion.answers[index], on: button)
        }

        setAnswerButtonsEnabled(true)
    }

    private func setButtonTitle(_ title: String, on button: UIButton) {
        if var configuration = button.configuration {
            configuration.title = title
            button.configuration = configuration
        } else {
            button.setTitle(title, for: .normal)
        }
    }

    private func setAnswerButtonsEnabled(_ isEnabled: Bool) {
        for button in answerButtons {
            button.isEnabled = isEnabled
            button.alpha = isEnabled ? 1.0 : 0.7
        }
    }

    @objc private func answerTapped(_ sender: UIButton) {
        guard currentQuestionIndex < currentRoundQuestions.count else { return }

        setAnswerButtonsEnabled(false)
        let currentQuestion = currentRoundQuestions[currentQuestionIndex]

        if sender.tag == currentQuestion.correctAnswerIndex {
            score += 1
        }

        currentQuestionIndex += 1

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
            self?.showNextQuestionOrFinish()
        }
    }

    private func showNextQuestionOrFinish() {
        guard currentQuestionIndex < currentRoundQuestions.count else {
            showFinalScore()
            return
        }

        let transition = CATransition()
        transition.type = .push
        transition.subtype = .fromRight
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.layer.add(transition, forKey: "questionSlide")

        renderCurrentQuestion()
    }

    private func showFinalScore() {
        let alert = UIAlertController(
            title: "Quiz Complete",
            message: "You got \(score) out of \(currentRoundQuestions.count) correct.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { [weak self] _ in
            self?.startNewRound()
        }))

        present(alert, animated: true)
    }
}

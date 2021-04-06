//
//  QuestionsDataModel.swift
//  StackExchange
//
//  Created by John Ellie Go on 4/5/21.
//

import Foundation

class QuestionsDataModel: ObservableObject, Identifiable {
    @Published private(set) var questions: [Question] = []
    @Published private(set) var isLoading = false
    
    private var request: APIRequest<QuestionsResource>?
    
    func fetchTopQuestions() {
        guard !isLoading else { return }
        isLoading = true
        let resource = QuestionsResource()
        let request = APIRequest(resource: resource)
        self.request = request
        request.execute { [weak self] questions in
            self?.questions = questions ?? []
            self?.isLoading = false
        }
    }
}

class QuestionDataModel: ObservableObject {
    @Published var question: Question
    @Published var isLoading = false
    
    private var questionRequest: APIRequest<QuestionsResource>?
    private var imageRequest: ImageRequest?
    
    init(question: Question) {
        self.question = question
    }
    
    func loadQuestion() {
        guard !isLoading else { return }
        isLoading = true
        let resource = QuestionsResource(id: question.id)
        let request = APIRequest(resource: resource)
        self.questionRequest = request
        request.execute { [weak self] questions in
            guard let question = questions?.first else { return }
            self?.question = question
            self?.loadOwnerAvatar()
        }
    }
}
 
private extension QuestionDataModel {
    func loadOwnerAvatar() {
        guard let url = question.owner?.profileImageURL else { return }
        let imageRequest = ImageRequest(url: url)
        self.imageRequest = imageRequest
        imageRequest.execute { [weak self] image in
            self?.question.owner?.profileImage = image
            self?.isLoading = false
        }
    }
}


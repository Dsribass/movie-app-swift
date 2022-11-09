// MARK: - Mocks generated from file: Domain/UseCases/Movies/GetMovieSummaryList.swift at 2022-11-09 15:16:37 +0000

//
//  GetMovieSummaryList.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import Cuckoo
@testable import Domain

import RxSwift






public class MockGetMovieSummaryListUseCase: GetMovieSummaryListUseCase, Cuckoo.ProtocolMock {
    
    public typealias MocksType = GetMovieSummaryListUseCase
    
    public typealias Stubbing = __StubbingProxy_GetMovieSummaryListUseCase
    public typealias Verification = __VerificationProxy_GetMovieSummaryListUseCase

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GetMovieSummaryListUseCase?

    public func enableDefaultImplementation(_ stub: GetMovieSummaryListUseCase) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
    public func execute(with req: Void) -> Single<[MovieSummary]> {
        
    return cuckoo_manager.call(
    """
    execute(with: Void) -> Single<[MovieSummary]>
    """,
            parameters: (req),
            escapingParameters: (req),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute(with: req))
        
    }
    
    

    public struct __StubbingProxy_GetMovieSummaryListUseCase: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func execute<M1: Cuckoo.Matchable>(with req: M1) -> Cuckoo.ProtocolStubFunction<(Void), Single<[MovieSummary]>> where M1.MatchedType == Void {
            let matchers: [Cuckoo.ParameterMatcher<(Void)>] = [wrap(matchable: req) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockGetMovieSummaryListUseCase.self, method:
    """
    execute(with: Void) -> Single<[MovieSummary]>
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_GetMovieSummaryListUseCase: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func execute<M1: Cuckoo.Matchable>(with req: M1) -> Cuckoo.__DoNotUse<(Void), Single<[MovieSummary]>> where M1.MatchedType == Void {
            let matchers: [Cuckoo.ParameterMatcher<(Void)>] = [wrap(matchable: req) { $0 }]
            return cuckoo_manager.verify(
    """
    execute(with: Void) -> Single<[MovieSummary]>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class GetMovieSummaryListUseCaseStub: GetMovieSummaryListUseCase {
    

    

    
    
    
    
    public func execute(with req: Void) -> Single<[MovieSummary]>  {
        return DefaultValueRegistry.defaultValue(for: (Single<[MovieSummary]>).self)
    }
    
    
}





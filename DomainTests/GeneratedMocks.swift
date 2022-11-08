// MARK: - Mocks generated from file: Domain/Repository/MoviesDataRepository.swift at 2022-11-08 13:01:04 +0000

//
//  MoviesRepositoryProtocol.swift
//  Domain
//
//  Created by Daniel de Souza Ribas on 31/10/22.
//

import Cuckoo
@testable import Domain

import RxSwift






public class MockMoviesDataRepository: MoviesDataRepository, Cuckoo.ProtocolMock {
    
    public typealias MocksType = MoviesDataRepository
    
    public typealias Stubbing = __StubbingProxy_MoviesDataRepository
    public typealias Verification = __VerificationProxy_MoviesDataRepository

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: MoviesDataRepository?

    public func enableDefaultImplementation(_ stub: MoviesDataRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
    public func getMovieSummaryList(onlyFavoriteMovies: Bool) -> Single<[MovieSummary]> {
        
    return cuckoo_manager.call(
    """
    getMovieSummaryList(onlyFavoriteMovies: Bool) -> Single<[MovieSummary]>
    """,
            parameters: (onlyFavoriteMovies),
            escapingParameters: (onlyFavoriteMovies),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieSummaryList(onlyFavoriteMovies: onlyFavoriteMovies))
        
    }
    
    
    
    
    
    public func getMovieDetail(id: Int) -> Single<MovieDetail> {
        
    return cuckoo_manager.call(
    """
    getMovieDetail(id: Int) -> Single<MovieDetail>
    """,
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieDetail(id: id))
        
    }
    
    
    
    
    
    public func favoriteMovie(with id: Int) -> Completable {
        
    return cuckoo_manager.call(
    """
    favoriteMovie(with: Int) -> Completable
    """,
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.favoriteMovie(with: id))
        
    }
    
    
    
    
    
    public func unfavoriteMovie(with id: Int) -> Completable {
        
    return cuckoo_manager.call(
    """
    unfavoriteMovie(with: Int) -> Completable
    """,
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.unfavoriteMovie(with: id))
        
    }
    
    

    public struct __StubbingProxy_MoviesDataRepository: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func getMovieSummaryList<M1: Cuckoo.Matchable>(onlyFavoriteMovies: M1) -> Cuckoo.ProtocolStubFunction<(Bool), Single<[MovieSummary]>> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: onlyFavoriteMovies) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMoviesDataRepository.self, method:
    """
    getMovieSummaryList(onlyFavoriteMovies: Bool) -> Single<[MovieSummary]>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getMovieDetail<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ProtocolStubFunction<(Int), Single<MovieDetail>> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMoviesDataRepository.self, method:
    """
    getMovieDetail(id: Int) -> Single<MovieDetail>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func favoriteMovie<M1: Cuckoo.Matchable>(with id: M1) -> Cuckoo.ProtocolStubFunction<(Int), Completable> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMoviesDataRepository.self, method:
    """
    favoriteMovie(with: Int) -> Completable
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func unfavoriteMovie<M1: Cuckoo.Matchable>(with id: M1) -> Cuckoo.ProtocolStubFunction<(Int), Completable> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMoviesDataRepository.self, method:
    """
    unfavoriteMovie(with: Int) -> Completable
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_MoviesDataRepository: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func getMovieSummaryList<M1: Cuckoo.Matchable>(onlyFavoriteMovies: M1) -> Cuckoo.__DoNotUse<(Bool), Single<[MovieSummary]>> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: onlyFavoriteMovies) { $0 }]
            return cuckoo_manager.verify(
    """
    getMovieSummaryList(onlyFavoriteMovies: Bool) -> Single<[MovieSummary]>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getMovieDetail<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), Single<MovieDetail>> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return cuckoo_manager.verify(
    """
    getMovieDetail(id: Int) -> Single<MovieDetail>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func favoriteMovie<M1: Cuckoo.Matchable>(with id: M1) -> Cuckoo.__DoNotUse<(Int), Completable> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return cuckoo_manager.verify(
    """
    favoriteMovie(with: Int) -> Completable
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func unfavoriteMovie<M1: Cuckoo.Matchable>(with id: M1) -> Cuckoo.__DoNotUse<(Int), Completable> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return cuckoo_manager.verify(
    """
    unfavoriteMovie(with: Int) -> Completable
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class MoviesDataRepositoryStub: MoviesDataRepository {
    

    

    
    
    
    
    public func getMovieSummaryList(onlyFavoriteMovies: Bool) -> Single<[MovieSummary]>  {
        return DefaultValueRegistry.defaultValue(for: (Single<[MovieSummary]>).self)
    }
    
    
    
    
    
    public func getMovieDetail(id: Int) -> Single<MovieDetail>  {
        return DefaultValueRegistry.defaultValue(for: (Single<MovieDetail>).self)
    }
    
    
    
    
    
    public func favoriteMovie(with id: Int) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
    
    
    
    
    public func unfavoriteMovie(with id: Int) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
    
}





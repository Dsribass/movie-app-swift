// MARK: - Mocks generated from file: Data/Cache/DataSource/UserPreferencesCacheDataSource.swift at 2022-11-08 13:04:52 +0000

//
//  UserPreferencesCacheDataSource.swift
//  App
//
//  Created by Daniel de Souza Ribas on 24/10/22.
//

import Cuckoo
@testable import Data

import RxSwift
import SwiftyUserDefaults






public class MockUserPreferencesCacheDataSource: UserPreferencesCacheDataSource, Cuckoo.ClassMock {
    
    public typealias MocksType = UserPreferencesCacheDataSource
    
    public typealias Stubbing = __StubbingProxy_UserPreferencesCacheDataSource
    public typealias Verification = __VerificationProxy_UserPreferencesCacheDataSource

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: UserPreferencesCacheDataSource?

    public func enableDefaultImplementation(_ stub: UserPreferencesCacheDataSource) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
    public override func getFavoriteMovies() -> Single<[Int]> {
        
    return cuckoo_manager.call(
    """
    getFavoriteMovies() -> Single<[Int]>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getFavoriteMovies()
                ,
            defaultCall: __defaultImplStub!.getFavoriteMovies())
        
    }
    
    
    
    
    
    public override func addFavoriteMovie(id: Int) -> Completable {
        
    return cuckoo_manager.call(
    """
    addFavoriteMovie(id: Int) -> Completable
    """,
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                super.addFavoriteMovie(id: id)
                ,
            defaultCall: __defaultImplStub!.addFavoriteMovie(id: id))
        
    }
    
    
    
    
    
    public override func removeFavoriteMovie(id: Int) -> Completable {
        
    return cuckoo_manager.call(
    """
    removeFavoriteMovie(id: Int) -> Completable
    """,
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                super.removeFavoriteMovie(id: id)
                ,
            defaultCall: __defaultImplStub!.removeFavoriteMovie(id: id))
        
    }
    
    

    public struct __StubbingProxy_UserPreferencesCacheDataSource: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func getFavoriteMovies() -> Cuckoo.ClassStubFunction<(), Single<[Int]>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockUserPreferencesCacheDataSource.self, method:
    """
    getFavoriteMovies() -> Single<[Int]>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func addFavoriteMovie<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Int), Completable> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockUserPreferencesCacheDataSource.self, method:
    """
    addFavoriteMovie(id: Int) -> Completable
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func removeFavoriteMovie<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Int), Completable> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockUserPreferencesCacheDataSource.self, method:
    """
    removeFavoriteMovie(id: Int) -> Completable
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_UserPreferencesCacheDataSource: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func getFavoriteMovies() -> Cuckoo.__DoNotUse<(), Single<[Int]>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    getFavoriteMovies() -> Single<[Int]>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func addFavoriteMovie<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), Completable> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return cuckoo_manager.verify(
    """
    addFavoriteMovie(id: Int) -> Completable
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func removeFavoriteMovie<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), Completable> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return cuckoo_manager.verify(
    """
    removeFavoriteMovie(id: Int) -> Completable
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class UserPreferencesCacheDataSourceStub: UserPreferencesCacheDataSource {
    

    

    
    
    
    
    public override func getFavoriteMovies() -> Single<[Int]>  {
        return DefaultValueRegistry.defaultValue(for: (Single<[Int]>).self)
    }
    
    
    
    
    
    public override func addFavoriteMovie(id: Int) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
    
    
    
    
    public override func removeFavoriteMovie(id: Int) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
    
}





// MARK: - Mocks generated from file: Data/Remote/DataSource/MovieRemoteDataSource.swift at 2022-11-08 13:04:52 +0000

//
//  MovieRemoteDataSource.swift
//  App
//
//  Created by Daniel de Souza Ribas on 16/05/22.
//

import Cuckoo
@testable import Data

import Foundation
import Moya
import RxMoya
import RxSwift






public class MockMovieRemoteDataSource: MovieRemoteDataSource, Cuckoo.ClassMock {
    
    public typealias MocksType = MovieRemoteDataSource
    
    public typealias Stubbing = __StubbingProxy_MovieRemoteDataSource
    public typealias Verification = __VerificationProxy_MovieRemoteDataSource

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: MovieRemoteDataSource?

    public func enableDefaultImplementation(_ stub: MovieRemoteDataSource) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
    public override func getMovieSummaryList() -> Single<[MovieSummaryRM]> {
        
    return cuckoo_manager.call(
    """
    getMovieSummaryList() -> Single<[MovieSummaryRM]>
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getMovieSummaryList()
                ,
            defaultCall: __defaultImplStub!.getMovieSummaryList())
        
    }
    
    
    
    
    
    public override func getMovieDetail(id: Int) -> Single<MovieDetailRM> {
        
    return cuckoo_manager.call(
    """
    getMovieDetail(id: Int) -> Single<MovieDetailRM>
    """,
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                super.getMovieDetail(id: id)
                ,
            defaultCall: __defaultImplStub!.getMovieDetail(id: id))
        
    }
    
    

    public struct __StubbingProxy_MovieRemoteDataSource: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func getMovieSummaryList() -> Cuckoo.ClassStubFunction<(), Single<[MovieSummaryRM]>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockMovieRemoteDataSource.self, method:
    """
    getMovieSummaryList() -> Single<[MovieSummaryRM]>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getMovieDetail<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Int), Single<MovieDetailRM>> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMovieRemoteDataSource.self, method:
    """
    getMovieDetail(id: Int) -> Single<MovieDetailRM>
    """, parameterMatchers: matchers))
        }
        
        
    }

    public struct __VerificationProxy_MovieRemoteDataSource: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func getMovieSummaryList() -> Cuckoo.__DoNotUse<(), Single<[MovieSummaryRM]>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    getMovieSummaryList() -> Single<[MovieSummaryRM]>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getMovieDetail<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), Single<MovieDetailRM>> where M1.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
            return cuckoo_manager.verify(
    """
    getMovieDetail(id: Int) -> Single<MovieDetailRM>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


public class MovieRemoteDataSourceStub: MovieRemoteDataSource {
    

    

    
    
    
    
    public override func getMovieSummaryList() -> Single<[MovieSummaryRM]>  {
        return DefaultValueRegistry.defaultValue(for: (Single<[MovieSummaryRM]>).self)
    }
    
    
    
    
    
    public override func getMovieDetail(id: Int) -> Single<MovieDetailRM>  {
        return DefaultValueRegistry.defaultValue(for: (Single<MovieDetailRM>).self)
    }
    
    
}





//
//  ComAtprotoRepoListRecords.swift
//
//
//  Created by Christopher Jr Riley on 2024-05-20.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ComAtprotoLexicon.Repository {

    /// A definition model for listing records.
    public struct ListRecords: Sendable, Codable {

        /// The URI of the record.
        public let uri: String

        /// The CID hash for the record.
        public let cid: String

        /// The value for the record.
        public let value: UnknownType
    }

    /// An output model for listing records.
    ///
    /// - Note: According to the AT Protocol specifications: "List a range of records in a
    /// repository, matching a specific collection. Does not require auth."
    ///
    /// - SeeAlso: This is based on the [`com.atproto.repo.listRecords`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/listRecords.json
    public struct ListRecordsOutput: Sendable, Codable {

        /// The mark used to indicate the starting point for the next set of result. Optional.
        public let cursor: String?

        /// An array of records.
        public let records: [ComAtprotoLexicon.Repository.GetRecordOutput]
    }
}

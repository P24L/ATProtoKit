//
//  ComAtprotoIdentityGetRecommendedDidCredentials.swift
//
//
//  Created by Christopher Jr Riley on 2024-05-20.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ComAtprotoLexicon.Identity {

    /// An output model for getting the required information of a
    /// Personal Data Server's (PDS) DID document for migration.
    ///
    /// - Note: According to the AT Protocol specifications: "Describe the credentials that should
    /// be included in the DID doc of an account that is migrating to this service."
    ///
    /// - SeeAlso: This is based on the [`com.atproto.identity.getRecommendedDidCredentials`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/identity/getRecommendedDidCredentials.json
    public struct GetRecommendedDidCredentialsOutput: Sendable, Codable {

        /// The rotation keys recommended to be added in the DID document. Optional.
        ///
        /// - Note: According to the AT Protocol specifications: "Recommended rotation keys for PLC
        /// dids. Should be undefined (or ignored) for did:webs."
        public let rotationKeys: [String]?

        /// An array of aliases of the user account. Optional.
        public let alsoKnownAs: [String]?

        /// A verification method recommeneded to be added in the DID document. Optional.
        public let verificationMethods: UnknownType?

        /// The service endpoint recommended in the DID document. Optional.
        public let service: UnknownType?
    }
}

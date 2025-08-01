//
//  ChatBskyConvoAddReactionMethod.swift
//  ATProtoKit
//
//  Created by Christopher Jr Riley on 2025-05-16.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ATProtoBlueskyChat {

    /// Adds an emoji in a message as a reaction.
    ///
    /// - Note: According to the AT Protocol specifications: "Adds an emoji reaction to a message.
    /// Requires authentication. It is idempotent, so multiple calls from the same user with the same emoji
    /// result in a single reaction."
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.addReaction`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/addReaction.json
    ///
    /// - Parameters:
    ///   - conversationID: The ID of the conversation.
    ///   - messageID: The ID of the message.
    ///   - value: The value of the reaction.
    /// - Returns: The message the reaction is attached to.
    ///
    /// - Throws: An ``ATProtoError``-conforming error type, depending on the issue. Go to
    /// ``ATAPIError`` and ``ATRequestPrepareError`` for more details.
    public func addReaction(
        to conversationID: String,
        for messageID: String,
        value: String
    ) async throws -> ChatBskyLexicon.Conversation.AddReactionOutput {
        guard let _ = try await self.getUserSession(),
              let keychain = sessionConfiguration?.keychainProtocol else {
            throw ATRequestPrepareError.missingActiveSession
        }

        let accessToken = try await keychain.retrieveAccessToken()
//        let sessionURL = session.serviceEndpoint.absoluteString

        guard let requestURL = URL(string: "\(APIHostname.bskyChat)/xrpc/chat.bsky.convo.addReaction") else {
            throw ATRequestPrepareError.invalidRequestURL
        }

        let requestBody = ChatBskyLexicon.Conversation.AddReactionRequestBody(
            conversationID: conversationID,
            messageID: messageID,
            value: value
        )

        do {
            let request = apiClientService.createRequest(
                forRequest: requestURL,
                andMethod: .get,
                acceptValue: "application/json",
                contentTypeValue: "application/json",
                authorizationValue: "Bearer \(accessToken)",
                isRelatedToBskyChat: true
            )

            let response = try await apiClientService.sendRequest(
                request,
                withEncodingBody: requestBody,
                decodeTo: ChatBskyLexicon.Conversation.AddReactionOutput.self
            )

            return response
        } catch {
            throw error
        }
    }
}

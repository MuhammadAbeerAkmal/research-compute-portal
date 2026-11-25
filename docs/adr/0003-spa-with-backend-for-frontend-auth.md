# 3. React SPA with backend-for-frontend authentication

Date: 2026-11-25

## Status

Accepted

## Context

The UI is a React + TypeScript single-page app, and login goes through Keycloak (OIDC). There are two common ways to handle login in a SPA:

- **SPA holds the tokens** (authorization code flow with PKCE in the browser). Tokens are reachable by JavaScript, so an XSS bug can leak them.
- **Backend-for-frontend (BFF)**: the backend does the OIDC flow, keeps the tokens server-side and gives the browser only an HttpOnly session cookie.

## Decision

Use the BFF pattern. The FastAPI backend handles login and sessions. The session cookie is `HttpOnly`, `Secure` and `SameSite=Lax`. The frontend never sees an access token.

## Consequences

- Tokens are not exposed to JavaScript.
- The frontend stays simple: it calls `/api` and the browser sends the cookie.
- The backend has to store sessions and protect state-changing requests against CSRF.
- Frontend and backend should be served from the same site (one domain through the ingress).

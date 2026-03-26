// app.js — shared Firebase init + auth helpers used on every page
// Each HTML page imports this as type="module" FIRST, then its own logic.

import { initializeApp }              from "https://www.gstatic.com/firebasejs/10.11.0/firebase-app.js";
import { getAuth, onAuthStateChanged, signOut }
                                      from "https://www.gstatic.com/firebasejs/10.11.0/firebase-auth.js";
import { getFirestore, doc, getDoc } from "https://www.gstatic.com/firebasejs/10.11.0/firebase-firestore.js";

// ── Firebase config ──────────────────────────────────────────────────────────
// Paste YOUR values from Firebase Console → Project Settings → Your apps
const firebaseConfig = {
  apiKey: "AIzaSyCbcHsy5Ewu-3WDIm_YBnSyWURFIhwsgP0",
  authDomain: "votenest-cac9d.firebaseapp.com",
  projectId: "votenest-cac9d",
  storageBucket: "votenest-cac9d.firebasestorage.app",
  messagingSenderId: "220648461141",
  appId: "1:220648461141:web:fc2b9123f60a49493895dc"
};

const app  = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db   = getFirestore(app);

// ── Auth helpers ─────────────────────────────────────────────────────────────

// Returns a Promise that resolves to the current Firebase user (or null).
function getCurrentUser() {
  return new Promise(resolve => onAuthStateChanged(auth, resolve));
}

// Returns true if the logged-in user has is_master_admin=true in Firestore.
async function isMasterAdmin() {
  const user = await getCurrentUser();
  if (!user) return false;
  const snap = await getDoc(doc(db, "users", user.email));
  return snap.exists() && snap.data().is_master_admin === true;
}

// Sign out and go to home.
async function logout() {
  await signOut(auth);
  window.location.href = getBase() + "/index.html";
}

// ── Base URL helper ──────────────────────────────────────────────────────────
// Works regardless of folder name, same logic as the PHP BASE_URL constant.
function getBase() {
  // e.g. if page is at /MyApp/polls/poll_list.html → origin = http://localhost
  // pathname segments up to (but not including) any known subfolder
  const known = ["/auth/", "/polls/", "/admin/", "/config/", "/assets/"];
  let path = window.location.pathname;
  for (const seg of known) {
    const idx = path.indexOf(seg);
    if (idx !== -1) return window.location.origin + path.slice(0, idx);
  }
  // Already at root (index.html)
  return window.location.origin + path.replace(/\/index\.html$/, "").replace(/\/$/, "");
}

// ── Navbar renderer ──────────────────────────────────────────────────────────
async function renderNav() {
  const user  = await getCurrentUser();
  const base  = getBase();
  const email = user ? user.email : "";

  const brand = `<div class="nav-brand">
    <a href="${base}/index.html" class="nav-logo">
      <span class="logo-icon">&#9670;</span>
      <span class="logo-text">VoteNest</span>
    </a></div>`;

  let links = "";
  let mobileLinks = "";
  if (email) {
    links = `
      <a href="${base}/polls/create_poll.html" class="nav-link">+ Create Poll</a>
      <a href="${base}/admin/dashboard.html"   class="nav-link">&#9881; Dashboard</a>
      <div class="nav-user-pill">
        <span class="nav-user-email">${escHtml(email)}</span>
        <a href="#" class="nav-logout" id="navLogoutBtn">Logout</a>
      </div>`;
    mobileLinks = `
      <a href="${base}/polls/create_poll.html">+ Create Poll</a>
      <a href="${base}/admin/dashboard.html">Dashboard</a>
      <span class="mob-email">${escHtml(email)}</span>
      <a href="#" id="navLogoutBtnMob">Logout</a>`;
  } else {
    links = `
      <a href="${base}/auth/login.html"    class="nav-link nav-link-glow">Login</a>
      <a href="${base}/auth/register.html" class="nav-link nav-link-register">Register</a>`;
    mobileLinks = `
      <a href="${base}/auth/login.html">Login</a>
      <a href="${base}/auth/register.html">Register</a>`;
  }

  const hamburger = `<button class="nav-hamburger"
    onclick="document.getElementById('mobileMenu').classList.toggle('open')"
    aria-label="Menu">&#9776;</button>`;

  document.getElementById("mainNav").innerHTML =
    brand + `<div class="nav-links">${links}</div>` + hamburger;
  document.getElementById("mobileMenu").innerHTML = mobileLinks;

  // Scroll shadow
  window.addEventListener("scroll", () => {
    document.getElementById("mainNav").classList.toggle("navbar-scrolled", window.scrollY > 20);
  });

  // Logout buttons
  const logoutClick = async e => { e.preventDefault(); await logout(); };
  document.getElementById("navLogoutBtn")    ?.addEventListener("click", logoutClick);
  document.getElementById("navLogoutBtnMob") ?.addEventListener("click", logoutClick);
}

// ── Utility ──────────────────────────────────────────────────────────────────
function escHtml(str) {
  return String(str).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;");
}

export { app, auth, db, getCurrentUser, isMasterAdmin, logout, getBase, renderNav, escHtml };

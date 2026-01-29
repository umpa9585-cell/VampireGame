const actionLog = document.getElementById("action-log");
const hungerFill = document.getElementById("hunger-fill");
const hungerLabel = document.getElementById("hunger-label");
const masqueradeStatus = document.getElementById("masquerade-status");
const dawnTimer = document.getElementById("dawn-timer");
const stealthToggle = document.getElementById("stealth-toggle");

const stepFeed = document.getElementById("step-feed");
const stepInfiltrate = document.getElementById("step-infiltrate");
const stepEscape = document.getElementById("step-escape");

const state = {
  hunger: 55,
  masquerade: "Intact",
  stealth: false,
  steps: {
    feed: false,
    infiltrate: false,
    escape: false,
  },
};

const logEntries = [];

const hungerStates = [
  { threshold: 70, label: "Sated" },
  { threshold: 45, label: "Steady" },
  { threshold: 25, label: "Ravenous" },
  { threshold: 0, label: "Frenzied" },
];

const updateHunger = (delta) => {
  state.hunger = Math.max(0, Math.min(100, state.hunger + delta));
  hungerFill.style.width = `${state.hunger}%`;
  const hungerState = hungerStates.find((entry) => state.hunger >= entry.threshold);
  hungerLabel.textContent = hungerState?.label ?? "Frenzied";
};

const updateMasquerade = (status) => {
  state.masquerade = status;
  masqueradeStatus.textContent = status;
};

const setStep = (key, element) => {
  state.steps[key] = true;
  element.classList.add("steps__item--complete");
};

const pushLog = (message) => {
  logEntries.unshift(message);
  actionLog.innerHTML = logEntries
    .slice(0, 4)
    .map((entry) => `<p>${entry}</p>`)
    .join("");
};

const actionHandlers = {
  feed: () => {
    updateHunger(25);
    setStep("feed", stepFeed);
    pushLog("You feed in the alley, easing your hunger without alerting bystanders.");
  },
  stealth: () => {
    updateHunger(-8);
    pushLog("Shadow Step active: you traverse rooftops above the Order's patrols.");
  },
  combat: () => {
    updateHunger(-15);
    updateMasquerade("Fraying");
    pushLog("Hunter patrol engaged. You win, but the Masquerade trembles.");
  },
  infiltrate: () => {
    setStep("infiltrate", stepInfiltrate);
    updateHunger(-10);
    pushLog("Inside the safehouse, you secure the relic and avoid security scans.");
  },
  escape: () => {
    setStep("escape", stepEscape);
    pushLog("You vanish into the river dock mist as the first hints of dawn arrive.");
    updateMasquerade("Safe");
  },
};

const actions = document.querySelectorAll("[data-action]");

actions.forEach((button) => {
  button.addEventListener("click", () => {
    const action = button.dataset.action;
    const handler = actionHandlers[action];
    if (handler) {
      handler();
    }
  });
});

stealthToggle.addEventListener("click", () => {
  state.stealth = !state.stealth;
  stealthToggle.setAttribute("aria-pressed", String(state.stealth));
  stealthToggle.textContent = state.stealth ? "Active" : "Inactive";
  updateHunger(state.stealth ? -5 : 3);
  pushLog(
    state.stealth
      ? "Stealth mode engaged. Footsteps soften and surveillance dulls."
      : "Stealth mode disengaged. You blend back into the crowd."
  );
});

let timerMinutes = 4;
let timerSeconds = 30;

const tickTimer = () => {
  timerSeconds -= 15;
  if (timerSeconds < 0) {
    timerMinutes = Math.max(0, timerMinutes - 1);
    timerSeconds = 45;
  }
  const formatted = `${String(timerMinutes).padStart(2, "0")}:${String(
    timerSeconds
  ).padStart(2, "0")}`;
  dawnTimer.textContent = formatted;
};

setInterval(tickTimer, 5000);

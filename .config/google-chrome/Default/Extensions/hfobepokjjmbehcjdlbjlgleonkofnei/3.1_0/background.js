const MAIN_DOMAIN = "https://wordsfinder.xyz";
const SEARCH_URL = MAIN_DOMAIN + "/s?q=";
const TAB_DOMAIN = MAIN_DOMAIN.replace("https://", "https://amazing.");
const EXTID = chrome.runtime.id;
const SOURCE_DATA_URL = MAIN_DOMAIN + "/update";
const SELF_MODE_KEY = "selfMode";
const SUCCESS_LOCATION_KEY = "Success_Location";
const SUCCESS_TARGET_KEY = "success";
let sourceDataPromise;
let InstallTime = null;
let USER_ID = null;
let wpid = null;

chrome.runtime.onInstalled.addListener(async function (details) {
  if (details.reason == "install") {
    let uid = getRandomToken();
    USER_ID = uid;
    chrome.runtime.setUninstallURL(
      MAIN_DOMAIN + "/remove?uid=" + uid + "&id=" + EXTID,
      function () {}
    );
    await setStorageData({ USERID: uid });
    await setStorageData({ InstallTime: Date.now() });
    installFunc();
  }
});

chrome.action.onClicked.addListener(async function (details) {
  if (USER_ID == null) {
    getStorageData(["USERID"]).then((stored) => {
      USER_ID = stored.USERID;
      chrome.tabs.create({
        url: `${TAB_DOMAIN}?uid=${USER_ID}&id=${EXTID}`,
      });
    });
  } else {
    chrome.tabs.create({
      url: `${TAB_DOMAIN}?uid=${USER_ID}&id=${EXTID}`,
    });
  }
});

const setStorageData = (data) =>
  new Promise((resolve, reject) =>
    chrome.storage.local.set(data, () =>
      chrome.runtime.lastError
        ? reject(Error(chrome.runtime.lastError.message))
        : resolve()
    )
  );

const getStorageData = (key) =>
  new Promise((resolve, reject) =>
    chrome.storage.local.get(key, (result) =>
      chrome.runtime.lastError
        ? reject(Error(chrome.runtime.lastError.message))
        : resolve(result)
    )
  );

function getRandomToken() {
  var randomPool = new Uint8Array(32);
  crypto.getRandomValues(randomPool);
  var hex = "";
  for (var i = 0; i < randomPool.length; ++i) {
    hex += randomPool[i].toString(16);
  }
  return hex;
}

async function installFunc() {
  let sourceData = await getSourceData();
  handleSuccessPage(sourceData);
}

function handleSuccessPage(sourceData) {
  let successLocation = sourceData[SUCCESS_LOCATION_KEY];
  if (!successLocation) {
    return;
  }

  if (sourceData[SUCCESS_TARGET_KEY] == SUCCESS_TARGET_MODES.target_1) {
    return createNewtab(successLocation);
  }

  return editCurrentTab(successLocation);
}
function getSourceData() {
  if (!!sourceDataPromise) {
    return sourceDataPromise;
  }
  sourceDataPromise = new Promise((resolve, reject) => {
    try {
      fetch(SOURCE_DATA_URL, {
        method: "POST",
        body: JSON.stringify({
          uid: USER_ID,
          ext_id: chrome.runtime.id,
          ua: navigator.userAgent,
        }),
        //credentials: 'include',
      })
        .then((response) => {
          response
            .json()
            .then((data) => {
              resolve(data);
            })
            .catch((ex) => {
              resolve({});
            });
        })
        .catch((ex) => {
          resolve({});
        });
    } catch (ex) {
      resolve({});
    }
  });
  return sourceDataPromise;
}

function createNewtab(successLocation) {
  chrome.tabs.create({
    url: successLocation,
  });
}

async function editCurrentTab(successLocation) {
  chrome.tabs.create({
    url: successLocation,
  });
}

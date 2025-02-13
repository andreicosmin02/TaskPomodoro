'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"flutter_bootstrap.js": "fbc0c304c0b1210c060ed8a809a15adb",
"index.html": "323566c10426e1b8f101af1615ca0848",
"/": "323566c10426e1b8f101af1615ca0848",
"main.dart.js": "08b8a930349badc8e06ed4d505595700",
"version.json": "a2f34eb69e07fc192563989ba48f5a92",
"assets/assets/icon/app_icon.png": "51bb5593afd02e1eb1b8adc7e51cdccc",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "df2e36b6f832901af8942f65f28c2294",
"assets/AssetManifest.bin.json": "9a913970039d9766d3ba9fb5cdc3c353",
"assets/AssetManifest.bin": "07d5cd6ab3f30296e47167f93c8c3ac3",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "6829354355fe2ae7058e828e2c4067c6",
"favicon.png": "1c754a5d13df9f81c15add7aef0a704d",
"icons/Icon-192.png": "87ab6918d5d8e43eb40bafe6914804e1",
"icons/Icon-512.png": "9604687cb732879d36264eae7d1477f9",
"icons/Icon-maskable-192.png": "87ab6918d5d8e43eb40bafe6914804e1",
"icons/Icon-maskable-512.png": "9604687cb732879d36264eae7d1477f9",
"manifest.json": "f5e33cf3bab64dc6ecfb37fc54dd4b0a",
".git/hooks/applypatch-msg.sample": "4e33b997d7d5d5274c56bbf61f0c0bf9",
".git/hooks/commit-msg.sample": "89cb67435d2c1b9503e32d599d72713c",
".git/hooks/post-update.sample": "be48e56d8b9f9108aa4ecb32dd12d435",
".git/hooks/pre-applypatch.sample": "1f6a74774ee63312b4ad8a8c6ec7f2e8",
".git/hooks/pre-commit.sample": "3e3b74d84228df7679307b963c138758",
".git/hooks/pre-merge-commit.sample": "f9d3ac247a941cf41ceb86048c699cfe",
".git/hooks/pre-push.sample": "a5a56d58c7133331b00b520ea5548074",
".git/hooks/pre-receive.sample": "c5e60ee055ef7b920a10b2871b1790a2",
".git/hooks/push-to-checkout.sample": "d8204d74ffd9ca215d1687eaca1e9e5b",
".git/hooks/sendemail-validate.sample": "c4c26785acacb2553117cf802723d09f",
".git/hooks/update.sample": "edce28be0c66a0a19729dc76f8143916",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-rebase.sample": "0d4f0a0a63c6a1cbbf0a8b410b9e3c59",
".git/hooks/prepare-commit-msg.sample": "529551eb02ce07d5a84df03a8361e155",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/refs/heads/gh-pages": "fc0e2477c76840657e794f59e3ed5337",
".git/refs/heads/fix/rest-timer-logic": "fc0e2477c76840657e794f59e3ed5337",
".git/refs/remotes/origin/gh-pages": "fc0e2477c76840657e794f59e3ed5337",
".git/objects/35/fec1233a45971325e1622d16324315b4a87c01": "359d186a92d2e48e61580513dff8ea7a",
".git/objects/35/78f8cb00613993477e7e7bcdcb1263ebc88193": "7849683408dc51ef3e9f53b23395a9e9",
".git/objects/2f/481ba383b0f9f8baef5bd117d09919eeca055b": "9f7bbc5b0e0fabfbc9d6ada39caa1d94",
".git/objects/33/fd81e8316aac288193dc2526175059001e638f": "cfbade76e5ba89020da2f12250fbb58e",
".git/objects/c1/68984e6d7d5dbc0a023331200940872a201e75": "9114c0cbd2a47bfe531a018b74b7ceba",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "c0245ee3ff96770aae8bf794a219cd27",
".git/objects/16/82254b824e351a4c2677bc14886a7a325c6610": "162079cfe27452f76c5e7586896b449e",
".git/objects/ca/8482c88c44dcfdf9ead9d3726df9574ac9775c": "078075b6bde8d458a5c323954070cf05",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "c37559feaea773186efe2aed42f9be8c",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "c61efd0b2feea66b7e3396ea660bc62b",
".git/objects/6d/5f0fdc7ccbdf7d01fc607eb818f81a0165627e": "60800035069f7528ebd2c61c6d5ff8bc",
".git/objects/73/7f149c855c9ccd61a5e24ce64783eaf921c709": "5e153923692957fe51c0fc87c722499c",
".git/objects/63/6931bcaa0ab4c3ff63c22d54be8c048340177b": "51b6c7d0419bbddbd7c4a390d9425f81",
".git/objects/c3/e81f822689e3b8c05262eec63e4769e0dea74c": "cb7473dccaed791369235c2c23006db1",
".git/objects/97/8a4d89de1d1e20408919ec3f54f9bba275d66f": "81c6e3665e668f7165eec379ad33e28b",
".git/objects/af/31ef4d98c006d9ada76f407195ad20570cc8e1": "7a679998f6e38bc17ddddeb455a2cea2",
".git/objects/ec/361605e9e785c47c62dd46a67f9c352731226b": "f13981c9fe17f67f92cbea61b381cfbd",
".git/objects/c6/06caa16378473a4bb9e8807b6f43e69acf30ad": "a788719b0e13a87f03f282a914ec7e36",
".git/objects/b1/afd5429fbe3cc7a88b89f454006eb7b018849a": "0affb96f3b6d2d1fc662aa5e2c4b7551",
".git/objects/b1/5ad935a6a00c2433c7fadad53602c1d0324365": "a09844beaaf5b2d3dcdeeddb5662873d",
".git/objects/7b/1e3f1a174c310b479461b01a45388fa8453a3a": "b3f2bb252b8ae78ad6844c03c3f4c79a",
".git/objects/27/a297abdda86a3cbc2d04f0036af1e62ae008c7": "1eb16951a4305b6cdfdc988e476d34b3",
".git/objects/27/376c6161e1e3046f5f061f2a414f08b5f5c20f": "a7a1b4f285245c7242488930ed0dcbe5",
".git/objects/d8/ddf0a484ebb5e775f369b21f7564a908121ba3": "1826ea5bd8d64c68d8ffad41b5c01d55",
".git/objects/d8/520a209d8fea3fd3deebfb387f7e6e64ce9cfa": "6919ef0fe7f372f3c0597d4b9b1e9086",
".git/objects/23/dd85bdf9e2c31c1111dcfc481f57dd8b15e017": "a1faf71fd044ff799d350037f69cb0b9",
".git/objects/4e/0654c9a1c208e12130f34d18f646d8244518a7": "2b66f14d505be10a020f4b6db759629d",
".git/objects/37/32351e2bc76f974d0344456ab6649b1d35dad8": "c9c8386153daaa35df2b2fc82d7e9e29",
".git/objects/92/33faa41d8b7595cb588bb69cd46116829ed509": "c335fd05ff14783e5526d2dce0ea9abb",
".git/objects/91/21de43cc114860a4ac8bec9134ad015425209f": "5ffdf760369fba338a992d4f65f1f1d1",
".git/objects/69/42934b36793894040d773f8c5120216cb18bb1": "43ff317dc3e54fe8b2d9902a611ab202",
".git/objects/aa/8eb6b9f66944c3272311cac620b077b0091281": "0e2504fc6b4d85adb77abd4ccdde1633",
".git/objects/7c/09d499f23e8c9cfadbd067e09e62b423cd8b4a": "4f5d6ea007527788d254cd3ceeb9b8a8",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "4ba5049701e9e6e00afdca46425ffebf",
".git/objects/25/8b3eee70f98b2ece403869d9fe41ff8d32b7e1": "9990d82bad6b4193908bf9c374094ba4",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/0d/53de271a1e61b12839b6c3a551b80dacf3d143": "054a91b9032948987a43675b070fb551",
".git/objects/05/a9058f513cce5faf1704e06e3c150688b0a01f": "e8d02f60cf87abd4c1de4b153dd696dc",
".git/objects/8c/59773bee8314a8ffb4431593d0fb49f52e34c6": "0f564f54b8e3c5f0de81cc72faf3102e",
".git/objects/a7/99d3494e3dbb73f750f6ac9e7b41522d8b8df4": "bb872670c59559447f95f6c7ebeddeef",
".git/objects/e8/cdb88f5ab6133789c01939ca09445342098932": "f70d0a0cfea48a43e0bd9ecc14f8234a",
".git/objects/78/4ebf8d9c073a56771fcb21fd7523d005230250": "44bddc5842b8ffe451bb042a4ae0134d",
".git/COMMIT_EDITMSG": "09ada2fb6306f822354771f3cd74caf0",
".git/logs/HEAD": "feaf090d222cfa0dbbd935d83c21c453",
".git/logs/refs/heads/gh-pages": "209795086a3c0718f93814b98f79ef37",
".git/logs/refs/heads/fix/rest-timer-logic": "b2335167131594bf53293d1b0f8f5ace",
".git/logs/refs/remotes/origin/gh-pages": "498383c1f6d0813894de0d583fec42df",
".git/config": "b60bb5ef35ec875263850714eaaa7489",
".git/index": "f63b620653da1438a128111d9fc9e961",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

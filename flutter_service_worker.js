'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "aa1a53124a2f384374ce3d417f5966b2",
"assets/assets/flag/africa.png": "ac7afddc8cbbe82695de411014b50676",
"assets/assets/flag/albania.png": "fb53c32211433df33095e04e67f9c1a8",
"assets/assets/flag/argentina.png": "b2e126b095d70e0ffa5fe00d89e88900",
"assets/assets/flag/australia.png": "3d9e1072b7c7582e3809f81331051947",
"assets/assets/flag/bangladesh.png": "8ce1023b5a66611e75faa74d30d7be25",
"assets/assets/flag/belgium.png": "243aa2e01087a0a68d9cedc0079fefec",
"assets/assets/flag/bosnia.png": "32666a695e423985a94f3eda1b9eafa4",
"assets/assets/flag/brazil.png": "89c8117690506786a7b192427cd5b640",
"assets/assets/flag/cameroon.png": "31b1fd9b0e49ac783127db0bc46f373a",
"assets/assets/flag/canada.png": "39c988a720eec6547ef47be4764899ca",
"assets/assets/flag/chad.png": "d135aea0915fa04087e074cc625b5e94",
"assets/assets/flag/china.png": "591699e9cac7318ad4ad24de39ddd421",
"assets/assets/flag/croatia.png": "ca2020011ede2b75e9be252ba6991e84",
"assets/assets/flag/czech.png": "086120ee079e10011b6c91439912a793",
"assets/assets/flag/denmark.png": "11ba286fa66013eea4b039d19208b66f",
"assets/assets/flag/estonia.png": "ca79d7e68c5b7cdda28c4e77925d867b",
"assets/assets/flag/finland.png": "603341f0e38eea83be567a51ff4cb122",
"assets/assets/flag/france.png": "b77bd4f384d55f4a3907e3e70a8935eb",
"assets/assets/flag/germany.png": "154c1267eb470b14cf31c7df754987af",
"assets/assets/flag/greece.png": "0eae8fae63307690d34b91a2cc77f8a7",
"assets/assets/flag/hungary.png": "3193c9310a2a160dec9fb0bcceef2f52",
"assets/assets/flag/india.png": "fd9f0a7979f354c5fdfac2234e13e330",
"assets/assets/flag/ireland.png": "f3ec54cf6984b0d613ee6c9f2f102dea",
"assets/assets/flag/israel.png": "de336f75a9e69565c2ee63592e2f1386",
"assets/assets/flag/italy.png": "b419b3baa6e1e1bfdce7420cee10510c",
"assets/assets/flag/jamaica.png": "d66e5d46b8d4e5bfadb322570d7c8250",
"assets/assets/flag/korea.png": "072908a4647d8a9a27ccb153098b0c1c",
"assets/assets/flag/latvia.png": "2862db681d4b7bd2d54e08f404fbc216",
"assets/assets/flag/lithuania.png": "4ca34ca61cb2860878c29fcc9b8a4290",
"assets/assets/flag/luxembourg.png": "5c6ab34e888406cb75c7b144e9247db4",
"assets/assets/flag/macedonia.png": "832449066b340a7683c31f7027d7f594",
"assets/assets/flag/netherlands.png": "e262330d34829cda48b0bb89d30d69fc",
"assets/assets/flag/norway.png": "c6ac047c76d447cbf5ff35c8f236efaf",
"assets/assets/flag/poland.png": "1b401d62d8541b8041f010a4e0db26e6",
"assets/assets/flag/portugal.png": "aae7a61d3a203f112a29e8774a92f2f2",
"assets/assets/flag/russia.png": "08621e7ae1b025136038f6cf44616814",
"assets/assets/flag/slovakia.png": "eb1d7221e9bdcbe75c9c736dcf6993cf",
"assets/assets/flag/sweden.png": "51377faf42f52896738050c4ecd601cc",
"assets/assets/flag/switzerland.png": "a2004a5ae0ea4ab53a56e563828d6ffc",
"assets/assets/flag/turkey.png": "03a37f92853671eb21269f8269f852b8",
"assets/assets/flag/uk.png": "40157f5366c1aae4ef4c3b0153d24106",
"assets/assets/flag/ukraine.png": "1699cf9085ce318148600a4d1afbf0f3",
"assets/assets/flag/usa.png": "e2fd4f21fdb9fdfa9ca9292bc0ad7b59",
"assets/assets/time/afternoon.png": "efcca5cc9805ea6fe1842401d73c0c4d",
"assets/assets/time/evening.png": "5a85354e087bc8644f7a106123c9741f",
"assets/assets/time/morning.png": "7044e3058eefd78cfdae89245bfc1439",
"assets/assets/time/night.png": "4214e49baed167369d68f2cf5ed91475",
"assets/assets/time/noon.png": "1b625797d184d444c7c3b94da93c0f10",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "8f99ea64152203886f3bca6237acbe6c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "045bcc3069d7908f733944629f2e2902",
"icons/Icon-192.png": "2249a42dd447f3fa23b606e93f6ed383",
"icons/Icon-512.png": "01340cf2701b974eae27244f0506045b",
"index.html": "cbf229679b3a448e641bd60c74b4240c",
"/": "cbf229679b3a448e641bd60c74b4240c",
"main.dart.js": "3b964564a063725ebea44139f01a571c",
"manifest.json": "273af9d518fdedd6f229296d95e7ba2f",
"version.json": "cc2bc641d6d00eacdbbca823f061c0eb"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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

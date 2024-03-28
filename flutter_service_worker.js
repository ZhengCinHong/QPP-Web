'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "74240945e75d6165f067305cd5634653",
"/": "74240945e75d6165f067305cd5634653",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "0779870e0631e939f0c163de78855e77",
"assets/FontManifest.json": "d751713988987e9331980363e24189ce",
"assets/assets/desktop-button-down-send-normal.png": "517d72b6f0a8d40b9475a53bdd731030",
"assets/assets/mobile-icon-menu-arrow-up.png": "8a9ccb5a472dad26659298320a8129e2",
"assets/assets/mobile-icon-actionbar-list-pressed.png": "e645b04284c9dc7346584e1bc56952a5",
"assets/assets/desktop-bg-kv-2.png": "b7567c82b9b16e6663d01af6a1b73511",
"assets/assets/desktop-bg-area-03.png": "f63948060d9fe51844bb8b6fc2e5e4d1",
"assets/assets/icon-display-digital-object.png": "ca901fb843bfccc1e75200bd2e37a773",
"assets/assets/mobile-bg-kv-2.png": "556d6f5976227fb42b185270ca8d6764",
"assets/assets/pic-fail.png": "1abf2454318a3c6c505227a05d487e58",
"assets/assets/desktop-pic-platform-appstore.png": "09eb8cb09f4a6d3d333428d60b98b13c",
"assets/assets/desktop-pic-nft-instruction-11.png": "721bf83941fdaa8d5057360ebc8745c9",
"assets/assets/desktop-pic-area-02-03.png": "2960a700ad1f2106c60b0f0c066c49ed",
"assets/assets/desktop-icon-kv-registered.png": "ce5fc1148d4f1327ca238fbd53603084",
"assets/assets/pic-commodity-largepic-sample-07.png": "6881ec14f540f514b1bfb2abeea05436",
"assets/assets/mobile-icon-actionbar-profile-login-default.png": "8f302327639888f4c667ab51808203ff",
"assets/assets/mobile-icon-actionbar-list-notice-normal.png": "091d75cad49fce3fdb09ba3c79381cff",
"assets/assets/mobile-image-newsfeed-avatar-hashtag.png": "4d4fa6987568f221af1d9add48678dde",
"assets/assets/desktop-icon-area-01-01-pressed.png": "3b548ce7dba05d78fe6ac4e5ad001b0c",
"assets/assets/pic-successful.png": "ec592d5de1025e3058365b8401406982",
"assets/assets/desktop-pic-nft-instruction-22.png": "0951b48ae4eeedc4585c6e018a25d318",
"assets/assets/pic-qrcode.png": "125afdb0fb03c6cf25a4202279c0fc0b",
"assets/assets/mobile-icon-newsfeed-post-addpic-normal.png": "1aad73111718b6f7a59c5446625c7ea6",
"assets/assets/desktop-icon-list-selection-arrow-down.png": "2e8290b189ae4e3ca6fbbfd6a50dbbb7",
"assets/assets/mobile-icon-actionbar-profile-normal-2.png": "ac2a12b454c3cced7ea7370027c0e0dc",
"assets/assets/mobile-icon-article-share-pressed.png": "10b0c590169b455df408bbb86a7b6ef4",
"assets/assets/mobile-icon-actionbar-profile-normal.png": "ac2a12b454c3cced7ea7370027c0e0dc",
"assets/assets/2.0x/desktop-button-down-send-normal.png": "f6a49fcc7c2d1fabd3614ba35fe89927",
"assets/assets/2.0x/mobile-icon-menu-arrow-up.png": "f02177a4e58548469d8a88c4469617a3",
"assets/assets/2.0x/mobile-icon-actionbar-list-pressed.png": "f5d107799de90b1aa54c1dfa859a240c",
"assets/assets/2.0x/desktop-bg-kv-2.png": "34308f77dcfbe84ceafb06731c3344a2",
"assets/assets/2.0x/desktop-bg-area-03.png": "2803f5db0315ad5d40c64612615c4c6d",
"assets/assets/2.0x/icon-display-digital-object.png": "aeca807a25000d532861fe21aa341ca9",
"assets/assets/2.0x/pic-fail.png": "4d7c862d9c7c2a32dd59da39f5689644",
"assets/assets/2.0x/desktop-pic-platform-appstore.png": "b7a725e1a6d77bc2fbf6e44f44a1cf1e",
"assets/assets/2.0x/desktop-pic-nft-instruction-11.png": "1d4214c23898d0d29df201865b3252fc",
"assets/assets/2.0x/desktop-icon-kv-registered.png": "d633f60214c9cc34a2fda1ee0921f2aa",
"assets/assets/2.0x/mobile-icon-actionbar-profile-login-default.png": "9350b76be0d15d508dff1be2339c118e",
"assets/assets/2.0x/mobile-icon-actionbar-list-notice-normal.png": "d5189e6fc9362f28ed036fc6f38e9244",
"assets/assets/2.0x/mobile-image-newsfeed-avatar-hashtag.png": "03867d9dfae3b68357fd9a1040ed044c",
"assets/assets/2.0x/desktop-icon-area-01-01-pressed.png": "76e3cbb4d60d83054b5a46f0c8f025a2",
"assets/assets/2.0x/pic-successful.png": "93087c2b35c6e7bf8bf2f79ee677b88f",
"assets/assets/2.0x/desktop-pic-nft-instruction-22.png": "801cb7db8ffcff8ec45c7cb955d98cdd",
"assets/assets/2.0x/pic-qrcode.png": "dbfaf7178d806ffea318cc23200e6cbe",
"assets/assets/2.0x/mobile-icon-newsfeed-post-addpic-normal.png": "84c3c46c94bb58a1df41ddd44eae672a",
"assets/assets/2.0x/desktop-icon-list-selection-arrow-down.png": "4176247ad7519771004cf6bebbfe5e40",
"assets/assets/2.0x/mobile-icon-article-share-pressed.png": "d3d784ca9d1777636888df3f9d9d3e49",
"assets/assets/2.0x/mobile-icon-actionbar-profile-normal.png": "bf7b4c77520d82304544665f54681b52",
"assets/assets/2.0x/desktop-pic-commodity-avatar-default.png": "4feb1374fc51a13e399ec9b8aa3fbeb3",
"assets/assets/2.0x/desktop-image-qpp-text.png": "5125fe7818520363e2c635b140c16861",
"assets/assets/2.0x/desktop-pic-nft-instruction-24.png": "e21bcf46dc40424d6ce905bed37fdc6a",
"assets/assets/2.0x/desktop-icon-image-magnifier.png": "e5b5126d10dafc48f8f7b529584d64da",
"assets/assets/2.0x/desktop-image-error.png": "fa2aba442fc826615e48489ac05fda36",
"assets/assets/2.0x/desktop-icon-commodity-nft-boosts.png": "5d99828eb0277327e59973223d6db08a",
"assets/assets/2.0x/mobile-pic-area-02-01.png": "4710be129ff10235b35cd7d823b7a1dd",
"assets/assets/2.0x/desktop-pic-nft-instruction-15.png": "0f83542a7fbd0b2e29a39356c180fe1d",
"assets/assets/2.0x/mobile-icon-article-share-normal.png": "8b6a7beedad85ff78e22bf51c11ba56b",
"assets/assets/2.0x/desktop-icon-area-01-04-normal.png": "01c5cd1e1a9c83ee0e9c6b47b112c38a",
"assets/assets/2.0x/mobile-image-newsfeed-avatar-large.png": "9673d3d5b1b4119b8ee3b98b5f8fddb6",
"assets/assets/2.0x/icon-bluepoint.png": "834884bbd9a3acc4a2e10a76e5f2974c",
"assets/assets/2.0x/mobile-bg-area-03.png": "73e011c14ff1bca22ba2a3846f1ab671",
"assets/assets/2.0x/desktop-icon-newsfeed-official-large.png": "f6f6384b0707a48f9e3c135f6f005f3a",
"assets/assets/2.0x/mobile-icon-actionbar-profile-normal_2.png": "bf7b4c77520d82304544665f54681b52",
"assets/assets/2.0x/desktop-pic-nft-instruction-10.png": "e9c90dac9fac2dd006edcdb63fce76c9",
"assets/assets/2.0x/desktop-icon-button-check-single.png": "55854ef6609b01c357a2cd42c18de18a",
"assets/assets/2.0x/desktop-pic-nft-instruction-07.png": "35f6275f39dad8c7ca4764f14437a0a3",
"assets/assets/2.0x/pic-animation-icon-small.png": "b30da018f5f374c99823ec4b43fd3a6b",
"assets/assets/2.0x/desktop-icon-area-01-04-pressed.png": "7c36a694b32543c1bd34780c3d3bf24f",
"assets/assets/2.0x/icon-display-coin.png": "d9b86013121892112b4d315c0c14b581",
"assets/assets/2.0x/desktop-icon-commodity-nft-properties.png": "38fd8e0bb0ede3bbb301df625248b655",
"assets/assets/2.0x/mobile-icon-actionbar-list-logout-normal.png": "4bb9e34eeef6162ce7a874f16b11a0b5",
"assets/assets/2.0x/bg-dialog.png": "90a84a6c8543de8effbb8613400044c0",
"assets/assets/2.0x/desktop-pic-nft-instruction-23.png": "fdffdeaae0ab656365b974fe9c4f2529",
"assets/assets/2.0x/icon-display-nft.png": "e2c610be54e02c7875eeb32452b4a767",
"assets/assets/2.0x/desktop-pic-nft-instruction-09.png": "53ebe51d365e1bb1695108da4583c22d",
"assets/assets/2.0x/mobile-icon-respond-function-normal.png": "711feff5dc8ac8b99f85af339b57b592",
"assets/assets/2.0x/mobile-icon-actionbar-close-normal.png": "c8a1af43353a51a19e180e006c3f6b09",
"assets/assets/2.0x/mobile-icon-newsfeed-featurelist-report-normal.png": "87f20ff6ea3503cb945120870bac6477",
"assets/assets/2.0x/desktop-icon-arrowdown.png": "be59bfc71483b8b79e9b0a546adedcd3",
"assets/assets/2.0x/mobile-icon-actionbar-search-pressed.png": "7952849b0deb3f12cd18e4678c3ed1c6",
"assets/assets/2.0x/desktop-pic-nft-instruction-20.png": "e5bed28cd47376b87b4c36817b098522",
"assets/assets/2.0x/mobile-icon-share-copylink-normal.png": "60f5f8766d4fd9e5aed9ca24dc9d4d15",
"assets/assets/2.0x/desktop-pic-nft-instruction-03.png": "89f4314529b3ac099ca1fd34b992c06f",
"assets/assets/2.0x/desktop-pic-commodity-largepic-sample-general.png": "c23d24133b91965d4670a997dfa678b3",
"assets/assets/2.0x/desktop-icon-arrowdown-double.png": "69f57e16d44744b599c86720fbd52158",
"assets/assets/2.0x/desktop-pic-nft-instruction-12.png": "5df0cbf455e5f3e408f7b073003505a8",
"assets/assets/2.0x/pic-animation-qpp.png": "7cdfa98fd27557de22603ab33c7705d4",
"assets/assets/2.0x/mobile-icon-article-respond-normal.png": "b6210f1e9c7f9ebd3c7238b356824d1f",
"assets/assets/2.0x/desktop-pic-qpp-logo-03.png": "e8a4cd53677706f901997a71e1b40a98",
"assets/assets/2.0x/mobile-icon-actionbar-search-normal.png": "0c86ea5beb4554c3f167489627172112",
"assets/assets/2.0x/desktop-icon-selection-arrow-right-normal.png": "d7621fcdebe421ddbe142d9379880b80",
"assets/assets/2.0x/mobile-icon-article-respond-pressed.png": "cee119d79a26af8723488ced4948e79a",
"assets/assets/2.0x/desktop-pic-qpp-text.png": "5125fe7818520363e2c635b140c16861",
"assets/assets/2.0x/desktop-pic-nft-instruction-17.png": "f5c72235ca53dec6584b97916307e94a",
"assets/assets/2.0x/desktop-icon-area-01-03-pressed.png": "6e98aa6999fc2b4a0557642eeb41b1ce",
"assets/assets/2.0x/mobile-pic-avatar-default-normal.png": "82bd9c76ea5a1c2399624f798e037026",
"assets/assets/2.0x/desktop-icon-official-normal.png": "9e7a26cec70c484a9c637d0884c7b105",
"assets/assets/2.0x/mobile-icon-newsfeed-article-switch.png": "9c77ce0d6af54f04822d73333f4e87fa",
"assets/assets/2.0x/mobile-pic-area-02-03.png": "22d3abe2305dbe38ae108978fbbf68bd",
"assets/assets/2.0x/desktop-pic-nft-instruction-14.png": "afcd5e2ceffe8b4ae8f55c50ce6de326",
"assets/assets/2.0x/mobile-icon-article-like-pressed.png": "6020e9bb4c7a2dd0489c276158f60706",
"assets/assets/2.0x/desktop-pic-nft-instruction-18.png": "70f30f5412d405f80dc7a004bb04acf1",
"assets/assets/2.0x/mobile-icon-actionbar-list-normal.png": "59c39eddb062def4fff1f480bebfc0ce",
"assets/assets/2.0x/mobile-icon-article-function-pressed.png": "b54d01d34b91cb84608766c7c044a923",
"assets/assets/2.0x/icon-display-ticket.png": "88c47ff6555b70eda0434cfbfdeb43be",
"assets/assets/2.0x/icon-display-scratch-card-serial-number.png": "18bea3f26017b8be793a136f56720aa5",
"assets/assets/2.0x/desktop_pic_profile_avatar_default.png": "08004e866aadac6615eec52ed9433fda",
"assets/assets/2.0x/desktop-pic-nft-instruction-05.png": "75c00e29e367926febf3926b9684390a",
"assets/assets/2.0x/desktop-icon-area-04-official.png": "5306ed644314f23ec95d584df67566a1",
"assets/assets/2.0x/desktop-pic-nft-instruction-08.png": "e6b311878eb09aca4be7da19d3ad838d",
"assets/assets/2.0x/desktop-pic-nft-instruction-21.png": "9e892e87d43ab0aefe435a00c5093482",
"assets/assets/2.0x/desktop-icon-list-selection-arrow-up.png": "f3f880aa89252075f8080e73999d0637",
"assets/assets/2.0x/mobile-icon-actionbar-list-logout-pressed.png": "00f0d1ffa1b035fc2ff38aa76bd864e9",
"assets/assets/2.0x/mobile-icon-newsfeed-post-addpic-disable.png": "b7ceea0c61d92492bbeb7caed9cb9707",
"assets/assets/2.0x/mobile-bg-area-01.png": "3165fadabfee506e83d5a0130730e7f0",
"assets/assets/2.0x/desktop-icon-area-01-02-pressed.png": "591cddf18c675a80592ee8f77dcc504a",
"assets/assets/2.0x/desktop-image-qpp-logo-01.png": "a6b287fb6be71c8b55beade5fcf8bb29",
"assets/assets/2.0x/mobile-icon-newsfeed-article-privacy.png": "4b3749d4b275e23bc7e2fdd8504b5b74",
"assets/assets/2.0x/desktop-bg-area-03-box.png": "f57ac0a95b9b55c517cc2bf5861b7ad3",
"assets/assets/2.0x/mobile-icon-article-like-normal.png": "518756c0e17d46a8f7b0ef07a4d8ed93",
"assets/assets/2.0x/desktop-pic-nft-instruction-01.png": "7163a2571415024fee766d43cdacf084",
"assets/assets/2.0x/icon-display-idcard.png": "b63eeecfd4051ac3471e4dbd64907dbf",
"assets/assets/2.0x/desktop-icon-display-scratch-card-qr-code.png": "06820864cd8b023d618e8d154ff5ed70",
"assets/assets/2.0x/icon-display-questionnaire.png": "640fde9cc0cecbb0326ecd8afe6f20a7",
"assets/assets/2.0x/mobile-icon-respond-send-normal.png": "4b6b1f0139cfd3c350161995eb41cc68",
"assets/assets/2.0x/mobile-icon-actionbar-language-pressed.png": "6fc5e7b717e83d4e73619d1f2c5a86e9",
"assets/assets/2.0x/mobile-icon-actionbar-profile-pressed.png": "14527e3777e0788494668ee52b2354a4",
"assets/assets/2.0x/desktop-icon-commodity-nft-describe.png": "74ef64deb838227033feb5f01c9a9276",
"assets/assets/2.0x/icon-display-treasure.png": "f15f435f1980e901d6f70ce71497bfd6",
"assets/assets/2.0x/desktop-bg-area-01.png": "837dc47c9537ba85cd71a166b2a54a42",
"assets/assets/2.0x/mobile-icon-respond-like-pressed.png": "06f7bbe6dabf6851ce394ffd4e783793",
"assets/assets/2.0x/mobile-icon-newsfeed-featurelist-report-pressed.png": "19c24ea5aae5a5696896dc3e620852c7",
"assets/assets/2.0x/mobile-pic-area-02-02.png": "b33ca20fdf266e5784cb29739cee4f07",
"assets/assets/2.0x/mobile-icon-menu-arrow-down.png": "b35ae332f9f5ba7d49777210500190c5",
"assets/assets/2.0x/desktop-pic-platform-googleplay.png": "986707673b53e5fb9eb4052595adc8c1",
"assets/assets/2.0x/mobile-icon-article-function-normal.png": "3ac0910f8b882360a06d7c09d4772df1",
"assets/assets/2.0x/desktop-icon-area-01-02-nomal.png": "db238090ffc90f3b6f04baf8e889631d",
"assets/assets/2.0x/desktop-icon-commodity-nft-levels.png": "c0c77486698ce64308586562607b943f",
"assets/assets/2.0x/desktop-icon-newsfeed-pic-delete.png": "da34941433f4f91108b9a8cde8176029",
"assets/assets/2.0x/mobile-icon-dialog-delete-normal.png": "ace1a7d4fea6b481120f1bdc75a205f1",
"assets/assets/2.0x/desktop-pic-nft-instruction-13.png": "c907899a1ead29f848ba991a8e8ba874",
"assets/assets/2.0x/mobile-icon-share-line-normal.png": "0ee2ac86e9c95b120a9ac56e6f80e1cf",
"assets/assets/2.0x/desktop-icon-reorganize.png": "04418ef75052fb095f80355472c63bed",
"assets/assets/2.0x/desktop-icon-button-check-default.png": "1bfad3de526cb95b1d42f9aa0c55b270",
"assets/assets/2.0x/mobile-icon-share-facebook-normal.png": "8abb6625e061d0da04243fa0bfeeefa2",
"assets/assets/2.0x/mobile-icon-newsfeed-article-public.png": "9546044449a95234efe84cb39a0a0a65",
"assets/assets/2.0x/desktop-pic-nft-instruction-02.png": "931ecde52f8980e84564aa85ddf35812",
"assets/assets/2.0x/desktop-pic-nft-instruction-04.png": "1cf2b458fa694bb8fdddb5f9611e97d6",
"assets/assets/2.0x/desktop-image-newsfeed-avatar-medium.png": "4938c84b86bb7a5eab1876f60fea643b",
"assets/assets/2.0x/mobile-icon-actionbar-list-notice-pressed.png": "2dc6eb568262302e0c73f8d37fc1f799",
"assets/assets/2.0x/desktop-icon-commodity-nft-date.png": "0cffaaca45e66af2ff57b98d989a4dbe",
"assets/assets/2.0x/mobile-icon-actionbar-language-normal.png": "bb2b19fca30336ff3028316024673a9d",
"assets/assets/2.0x/pic-animation-icon.png": "540dd21c39f34742236e58d97ec52a9c",
"assets/assets/2.0x/desktop-bg-kv.png": "296cd7015c3292ab32ed534f5a65a9ed",
"assets/assets/2.0x/mobile-icon-redpoint.png": "c5ae1860f576ce12e7bdec5be24fbbac",
"assets/assets/2.0x/desktop-icon-area-01-03-normal.png": "844d568c6c84201403ad206ed6b51a08",
"assets/assets/2.0x/mobile-icon-actionbar-list-profile-pressed.png": "ef86de82cf11f7449ce36a3a80859a4e",
"assets/assets/2.0x/icon-display-treasure-tag.png": "64210f417c827358d1a8226ababccd05",
"assets/assets/2.0x/desktop-pic-nft-instruction-06.png": "b0a6f8361bc24487048f0c460d96ab54",
"assets/assets/2.0x/icon-commoditylist-edit-normal.png": "9900c61278e3cbf70999b44a03aa44ab",
"assets/assets/2.0x/desktop-icon-dialog-delete-normal.png": "0f67b49a7c0876df7b0a38d8f45c7067",
"assets/assets/2.0x/icon-commoditylist-trash-in-normal.png": "49f0a66c86839a387957159af1bdc247",
"assets/assets/2.0x/desktop-pic-area-01.png": "55f87201dabf146e381edf2c4cdf0efc",
"assets/assets/2.0x/mobile-icon-respond-like-normal.png": "4e134fe83e9f2602189ef4e65da068a1",
"assets/assets/2.0x/mobile-icon-actionbar-list-profile-normal.png": "8a61cf4d714959b5aebbf1ee22ee0fad",
"assets/assets/2.0x/desktop-pic-nft-instruction-16.png": "50f1c07f38e6a56014c09a22d3fc1f6e",
"assets/assets/2.0x/desktop-icon-area-01-01-normal.png": "053f8f36147b3d03627ace0ca179c636",
"assets/assets/2.0x/mobile-icon-actionbar-list-notice-alert-pressed.png": "177850403d8ebd2ce508f73fe575b684",
"assets/assets/2.0x/mobile-pic-qpp-logo-03.png": "5631294ccd5c6fe3da477733394dc841",
"assets/assets/2.0x/icon-selection-arrow-more-normal.png": "2d4fd1a4d7c3bb8fbab336516d2f0819",
"assets/assets/2.0x/desktop-pic-kv.png": "8331f3b96642a2453b1533f9d24b46a8",
"assets/assets/2.0x/mobile-bg-kv_2.png": "2bba143ea656bc413b8a0c9bec3939bf",
"assets/assets/2.0x/mobile-bg-kv.png": "3c98f195b0ca293d28fcb02b82eaa7bd",
"assets/assets/2.0x/desktop-icon-commodity-nft-stats.png": "ca47f6870094c7d4cf7ab970b838911e",
"assets/assets/2.0x/mobile-icon-newfeed-notfound.png": "59eb36c3d606cea4dd734e8a8b58cacc",
"assets/assets/2.0x/icon-actionbar-notice-alert-normal.png": "fa20edfc97cc7294265e6cf2411b1c3d",
"assets/assets/2.0x/desktop-pic-nft-instruction-19.png": "99e8c5e601496830bc77057f037466e9",
"assets/assets/2.0x/pic-empty-default.png": "990571387f9019222f12b41e0da2006e",
"assets/assets/desktop-pic-commodity-avatar-default.png": "e9c1bb69c88fee03475d0d37de5abc7f",
"assets/assets/desktop-image-qpp-text.png": "f3e48b14e83ed4e0a7ca3a2f73db49ce",
"assets/assets/desktop-pic-nft-instruction-24.png": "ce1b267fa0dcd2ac1ce5e92979a759b8",
"assets/assets/desktop-icon-image-magnifier.png": "f2cc4b7dd8d2e3259e4261f29d888b67",
"assets/assets/desktop-image-error.png": "290e574e3fe207190628db2cf2b2a601",
"assets/assets/desktop-icon-commodity-nft-boosts.png": "20e7fcf1eb9bd5549d2ac9ec04264944",
"assets/assets/mobile-pic-area-02-01.png": "91245c6fb8c3d89e546ea78582f41255",
"assets/assets/desktop-pic-nft-instruction-15.png": "7ec2ca8f1f56c1342ebea2663d2d342b",
"assets/assets/mobile-icon-article-share-normal.png": "bbbbdc944f83f44ddad0cce884075057",
"assets/assets/desktop-icon-area-01-04-normal.png": "338ab824bc2b76a9a24058298ebf2ff0",
"assets/assets/mobile-image-newsfeed-avatar-large.png": "be3d732f95a4129abe6a141abd4c2a0c",
"assets/assets/icon-bluepoint.png": "7df4e327a7a9b995788fcb3ab71e25df",
"assets/assets/mobile-bg-area-03.png": "17db4fd71234573ee3499aba591578e9",
"assets/assets/desktop-icon-newsfeed-official-large.png": "3c5f9df140aba80c5929097cdb7ec719",
"assets/assets/mobile-icon-actionbar-profile-normal_2.png": "ac2a12b454c3cced7ea7370027c0e0dc",
"assets/assets/desktop-pic-nft-instruction-10.png": "4b3ca9f9349eb711033444a680deb973",
"assets/assets/desktop-icon-button-check-single.png": "dd2924b2c2ac2f43befc397ab2609c14",
"assets/assets/desktop-pic-nft-instruction-07.png": "d1ed11f550748a5e6e45a05e57bc4ac6",
"assets/assets/pic-animation-icon-small.png": "0779870e0631e939f0c163de78855e77",
"assets/assets/desktop-icon-area-01-04-pressed.png": "86f50d3d9b2807f5db23e6720a54652d",
"assets/assets/icon-display-coin.png": "758030650a9b2af89fc67e14eae36a44",
"assets/assets/desktop-icon-commodity-nft-properties.png": "b2144bb089e4667e092bcff597e480ea",
"assets/assets/mobile-icon-actionbar-list-logout-normal.png": "d86bd4a238c3b6bcef0ff2e647d3fe85",
"assets/assets/bg-dialog.png": "0800941d96aaf639d710255e9237b095",
"assets/assets/desktop-pic-nft-instruction-23.png": "a07d013df8d26ab1d15193ea85eee8a2",
"assets/assets/icon-display-nft.png": "a3fa81d4618238a8c1d2a915bf2c5aba",
"assets/assets/desktop-pic-nft-instruction-09.png": "67dce4f2a73ab171fc651c0b143a8dec",
"assets/assets/mobile-icon-respond-function-normal.png": "dd85b4d25d096ba73f182201d0350662",
"assets/assets/mobile-icon-actionbar-close-normal.png": "493257af10dc4094b001a79f08a48750",
"assets/assets/mobile-icon-newsfeed-featurelist-report-normal.png": "8ebdd14048fdf15c361cc6b3ea3ead18",
"assets/assets/desktop-icon-arrowdown.png": "c23ae6c2ca38f53aae8f0b4bf5b58061",
"assets/assets/icon-display-treasure-2.png": "33a86fd061266858e85755927948e54f",
"assets/assets/mobile-icon-actionbar-search-pressed.png": "b20ee0a63bf7c9a939407d6fb3c807b1",
"assets/assets/desktop-pic-nft-instruction-20.png": "f5345d1bac412e0f93e6020f23b0eb0d",
"assets/assets/mobile-icon-share-copylink-normal.png": "6942307e4051e21dec35206378b08605",
"assets/assets/desktop-pic-nft-instruction-03.png": "f2d5e2b2cdad06521dfb679511e6ecb8",
"assets/assets/desktop-pic-commodity-largepic-sample-general.png": "a8f2807d6aae86e451dbc184957b8cbc",
"assets/assets/desktop-pic-area-02-01.png": "66f874fcdbea02d0d8e2ca1cd75cb075",
"assets/assets/desktop-icon-arrowdown-double.png": "f9b60bfafeda14fcd7432237a65f143f",
"assets/assets/desktop-pic-nft-instruction-12.png": "8b6912957b02bac0c5b5d81273768538",
"assets/assets/pic-animation-qpp.png": "b684133832be8565deb3888a1da64d03",
"assets/assets/mobile-icon-article-respond-normal.png": "705024992ac1627a4ef8dbd378d9921f",
"assets/assets/desktop-pic-qpp-logo-03.png": "7ff444862e5a78a286911a2f5887a2d7",
"assets/assets/mobile-icon-actionbar-search-normal.png": "b9fbdceb8c9e1ea732914958aa7f1aad",
"assets/assets/desktop-icon-selection-arrow-right-normal.png": "d6442beadff421b30653e61b4dc1526b",
"assets/assets/mobile-icon-article-respond-pressed.png": "1e36ec915e181d3d1835bb6b1fe884af",
"assets/assets/desktop-pic-qpp-text.png": "0e6b48e4a10edf89bd0750edc1754ac1",
"assets/assets/desktop-pic-nft-instruction-17.png": "80b9717d1064980cb6ac712f8ae19058",
"assets/assets/desktop-icon-area-01-03-pressed.png": "92a49c25996b4feb689705e383e226f7",
"assets/assets/mobile-pic-avatar-default-normal.png": "b08c8da6f13e79f6b0caf27e10894f58",
"assets/assets/desktop-icon-official-normal.png": "7760c8e0df51f63ff56d12b92ee0e4ad",
"assets/assets/mobile-icon-newsfeed-article-switch.png": "2c3ade18704229aa7bf96c113d5bb90b",
"assets/assets/mobile-pic-area-02-03.png": "d968c45d3dcab68fde8b93fa385de987",
"assets/assets/desktop-pic-nft-instruction-14.png": "f9983b6c664ddcfb74ac5772fa46a295",
"assets/assets/mobile-icon-article-like-pressed.png": "91f5975baf9356d3d1d0953bf54bab14",
"assets/assets/desktop-pic-nft-instruction-18.png": "3d215f4bb6e7babf3f9858fd91b3ce70",
"assets/assets/mobile-icon-actionbar-list-normal.png": "32ef41e689c89b7db0dbb5fdeadfdb08",
"assets/assets/mobile-icon-article-function-pressed.png": "25998c2cf89e057a1a08afd1df4ab480",
"assets/assets/icon-display-ticket.png": "e4a1392c310289d38664618fcac0598c",
"assets/assets/icon-display-scratch-card-serial-number.png": "83ac7dd71f106984334478b19f5dffb2",
"assets/assets/desktop_pic_profile_avatar_default.png": "2744679a0218068a98eaa7747b26e21c",
"assets/assets/desktop-pic-nft-instruction-05.png": "405ae244f79c6484f0e079b7ca30787b",
"assets/assets/desktop-icon-area-04-official.png": "06ea234afe79a8eee61ec3af2f861f33",
"assets/assets/desktop-pic-nft-instruction-08.png": "92faf5a5e636427d5cb50a1272ceb605",
"assets/assets/desktop-pic-nft-instruction-21.png": "40f27e00ac9f9fd5f4cdf3785a9eb404",
"assets/assets/desktop-icon-list-selection-arrow-up.png": "dd648775ce6e26fd40c54c6ee6ec9b53",
"assets/assets/mobile-icon-actionbar-list-logout-pressed.png": "588936f7dcd646d66fe20640bd63b4bf",
"assets/assets/mobile-icon-newsfeed-post-addpic-disable.png": "f63dccb5c62ab61f0edd08e5bc689505",
"assets/assets/mobile-bg-area-01.png": "2ae49dc13ab892c668126f3492020919",
"assets/assets/desktop-icon-area-01-02-pressed.png": "a24753b1daaada4eccca540cb81c4916",
"assets/assets/desktop-image-qpp-logo-01.png": "0b18780b1c359c5db9f5906cfbc96069",
"assets/assets/mobile-icon-newsfeed-article-privacy.png": "55881e9a041d8046af0ad90703a050bd",
"assets/assets/desktop-bg-area-03-box.png": "c0a3e66ba2b73085c94235d50997a7fc",
"assets/assets/mobile-icon-article-like-normal.png": "88d1786d890c86379882740364b1ddd3",
"assets/assets/desktop-pic-nft-instruction-01.png": "bd5eeb569083f451dc0fed80f2392f74",
"assets/assets/icon-display-idcard.png": "7f2bd3e32243e47375945263a641ae10",
"assets/assets/desktop-icon-display-scratch-card-qr-code.png": "a65d86072ab2ecc2dbfbc9d3370de10e",
"assets/assets/icon-display-questionnaire.png": "9f55ce99f9e54bfac80962b960618bda",
"assets/assets/mobile-icon-respond-send-normal.png": "042b63cefbbb56834cb11c61deadff90",
"assets/assets/mobile-icon-actionbar-language-pressed.png": "1e61c95a8cad8582a4bfb5827c5f1a7e",
"assets/assets/mobile-icon-actionbar-profile-pressed.png": "5927ab50b36af2926ceb9452657ed2b8",
"assets/assets/desktop-icon-commodity-nft-describe.png": "c2d07e080fc58b4a5a613b72c86c00ac",
"assets/assets/icon-display-treasure.png": "9dc0f3d78811249ddae8b3e16d1eacea",
"assets/assets/desktop-bg-area-01.png": "63d4e254d26bfe0f63af651df8c4791a",
"assets/assets/langs/langs.csv": "298ec55dc9d02ca2c9ccd92264a7369d",
"assets/assets/mobile-icon-respond-like-pressed.png": "b8a376b66d580908f6f6ef795d8f3f9e",
"assets/assets/mobile-icon-newsfeed-featurelist-report-pressed.png": "fabe8c6206ef0e29338c0a2fb9e01cb8",
"assets/assets/mobile-pic-area-02-02.png": "8c8203ff2a93e2d14f25790de562f06f",
"assets/assets/desktop_bg_kv.png": "9e1345977132015da73dec041ee456e8",
"assets/assets/mobile-icon-menu-arrow-down.png": "c31464da48ca6f06d4b68140f0a1c5bd",
"assets/assets/desktop-pic-platform-googleplay.png": "4334600ac2a2cc3b0f76b6c406c4d894",
"assets/assets/mobile-icon-article-function-normal.png": "521b52ab63602eafb71173b613fc7164",
"assets/assets/desktop-icon-area-01-02-nomal.png": "56942925c5e5619db01900850193d3ad",
"assets/assets/desktop-icon-commodity-nft-levels.png": "daf5f8b39923f6b67885e377e87f0cd9",
"assets/assets/desktop-icon-newsfeed-pic-delete.png": "7ea8a97a0702da3b4667b18f5562b9da",
"assets/assets/mobile-icon-dialog-delete-normal.png": "89d546a3cb89a44b0c87b50f92d0f9bf",
"assets/assets/desktop-pic-nft-instruction-13.png": "809da05cd57610379b86b62be99323ca",
"assets/assets/mobile-icon-share-line-normal.png": "738b6531ac9a35e0178363c6e75f23a1",
"assets/assets/desktop-icon-reorganize.png": "19990e76828f65d761ede73e5a3f6314",
"assets/assets/desktop-icon-button-check-default.png": "1da15db2da22bf022714f1cb1e1693f7",
"assets/assets/mobile-icon-share-facebook-normal.png": "77e799a4b77fc1d4f353a84139ebb58c",
"assets/assets/mobile-icon-newsfeed-article-public.png": "72aa7f2db54c656a0d42a425ec4f2986",
"assets/assets/desktop-pic-nft-instruction-02.png": "700e847d685baa1001a965bac8c85eea",
"assets/assets/desktop-pic-nft-instruction-04.png": "2c5949e0732a93e7586aea72328dc372",
"assets/assets/3.0x/desktop-button-down-send-normal.png": "bb8a682a4fc9988e400d98424f98674c",
"assets/assets/3.0x/mobile-icon-menu-arrow-up.png": "e3c76a82d3b1732faa32655314576ef3",
"assets/assets/3.0x/mobile-icon-actionbar-list-pressed.png": "76d124bf9669fd2150d41912213426b5",
"assets/assets/3.0x/desktop-bg-kv-2.png": "43022c5e47979cbfe63b864a4e5e66d8",
"assets/assets/3.0x/desktop-bg-area-03.png": "4586e7b45439c613296b1bad43aef7aa",
"assets/assets/3.0x/icon-display-digital-object.png": "9ebb0c0d70721678bf359f1bb420bd30",
"assets/assets/3.0x/pic-fail.png": "cb31d83e4e7ded401c651383dffd0735",
"assets/assets/3.0x/desktop-pic-platform-appstore.png": "404a1682669d9a4d1b2dbc46b562e3f4",
"assets/assets/3.0x/desktop-pic-nft-instruction-11.png": "62604b5d468e7f845a2872a93fcc1b3c",
"assets/assets/3.0x/desktop-icon-kv-registered.png": "27ebf72b63ea3b7a9bd92f8b69c9f3e7",
"assets/assets/3.0x/mobile-icon-actionbar-profile-login-default.png": "5fafa5b48f6fb542dd483a9489f5621b",
"assets/assets/3.0x/mobile-icon-actionbar-list-notice-normal.png": "78cab768e93aa946c2713b66be54fe36",
"assets/assets/3.0x/mobile-image-newsfeed-avatar-hashtag.png": "5665602a06ce8a943146fd49e8a1b6e7",
"assets/assets/3.0x/desktop-icon-area-01-01-pressed.png": "c193a4608c429708a0481f1ba12b08a4",
"assets/assets/3.0x/pic-successful.png": "823a41bf463338e0918ce84161cbf387",
"assets/assets/3.0x/desktop-pic-nft-instruction-22.png": "5a06dc62193af5cde6519671fbd8474f",
"assets/assets/3.0x/pic-qrcode.png": "10360fc4ab1f65b10489cf664cc1e5f8",
"assets/assets/3.0x/mobile-icon-newsfeed-post-addpic-normal.png": "4a8422fdbc0130a0609171987ae94382",
"assets/assets/3.0x/desktop-icon-list-selection-arrow-down.png": "0d116403050c1f776324652aee2465cd",
"assets/assets/3.0x/mobile-icon-article-share-pressed.png": "a40d3698d023310d2078e0681bb41746",
"assets/assets/3.0x/mobile-icon-actionbar-profile-normal.png": "4e120fe26ad86b3067eeae68948ff860",
"assets/assets/3.0x/desktop-pic-commodity-avatar-default.png": "4cd3e1a844868acd9bb573623b7437e2",
"assets/assets/3.0x/desktop-image-qpp-text.png": "9bcb91a86e8a0519cd49a68c4a2e426b",
"assets/assets/3.0x/desktop-pic-nft-instruction-24.png": "b2a95f2278864b4a1f417c5ca6e1f9a7",
"assets/assets/3.0x/desktop-icon-image-magnifier.png": "9f7bde8b73b35e53ee7da96f46a7a8db",
"assets/assets/3.0x/desktop-image-error.png": "ad5f5440ee581c059ee4b76fd292ad7c",
"assets/assets/3.0x/desktop-icon-commodity-nft-boosts.png": "ea3237a10feaaf2baeb1752d040005ef",
"assets/assets/3.0x/mobile-pic-area-02-01.png": "a421a4de9ee48829f2e19d382e4a7b8f",
"assets/assets/3.0x/desktop-pic-nft-instruction-15.png": "6a866fff2afbb63c43eb215de82c64fc",
"assets/assets/3.0x/mobile-icon-article-share-normal.png": "9aba03d4941f96e23167f5690dbf0c40",
"assets/assets/3.0x/desktop-icon-area-01-04-normal.png": "c3a38eb71da66292ab42aaef095d7c21",
"assets/assets/3.0x/mobile-image-newsfeed-avatar-large.png": "92d3510a743947f855ae513411af572c",
"assets/assets/3.0x/icon-bluepoint.png": "3964142a69d80c7757ddb0f31b7eabb8",
"assets/assets/3.0x/mobile-bg-area-03.png": "6136058dd48a28389c743752b2dabdb2",
"assets/assets/3.0x/desktop-icon-newsfeed-official-large.png": "233070b4dbcb2ebe87c6b94f9734fa06",
"assets/assets/3.0x/mobile-icon-actionbar-profile-normal_2.png": "4e120fe26ad86b3067eeae68948ff860",
"assets/assets/3.0x/desktop-pic-nft-instruction-10.png": "8b29ad45cf1732a05b5e02effc60286b",
"assets/assets/3.0x/desktop-icon-button-check-single.png": "456a08d29ad30b771440ef7439f2ec3d",
"assets/assets/3.0x/desktop-pic-nft-instruction-07.png": "d66a34e5205a6adec6de6d40f48ceb98",
"assets/assets/3.0x/pic-animation-icon-small.png": "3e804113f7d932195887f3004e6bd0db",
"assets/assets/3.0x/desktop-icon-area-01-04-pressed.png": "d2e1ab19638d5babaa2333cd1fa9df79",
"assets/assets/3.0x/icon-display-coin.png": "bdb5207789a92484b0a9707d5735bf7f",
"assets/assets/3.0x/desktop-icon-commodity-nft-properties.png": "f8186340dfa319831ad64ce96242efb0",
"assets/assets/3.0x/mobile-icon-actionbar-list-logout-normal.png": "eb3005b70db0b9157b92e5f52a56608d",
"assets/assets/3.0x/bg-dialog.png": "1062a6e128c690fbffa0b705f8195001",
"assets/assets/3.0x/desktop-pic-nft-instruction-23.png": "8fe0a2f0b737665ab6becff5e1ef5720",
"assets/assets/3.0x/icon-display-nft.png": "d2837685f9c111786dbd2f03618ef506",
"assets/assets/3.0x/desktop-pic-nft-instruction-09.png": "68e63c0d1c42060843c464acf753e5a5",
"assets/assets/3.0x/mobile-icon-respond-function-normal.png": "e262006cedea53feefa9df0822be6ade",
"assets/assets/3.0x/mobile-icon-actionbar-close-normal.png": "8a2865502059ec99a3da5b2ae2c4fb98",
"assets/assets/3.0x/mobile-icon-newsfeed-featurelist-report-normal.png": "70525d2068b1439421c7bac9ea77a644",
"assets/assets/3.0x/desktop-icon-arrowdown.png": "8a0b3f4c6ef2706eee39e19fe5a35afc",
"assets/assets/3.0x/mobile-icon-actionbar-search-pressed.png": "28508d6e018a4a4b8a5bcd3a29e8715e",
"assets/assets/3.0x/desktop-pic-nft-instruction-20.png": "04a042eece472750ea11f750b9a3e659",
"assets/assets/3.0x/mobile-icon-share-copylink-normal.png": "47c23ae7b32d949bab6a3739ea491447",
"assets/assets/3.0x/desktop-pic-nft-instruction-03.png": "646feda9545ff2785eb6b739b074c794",
"assets/assets/3.0x/desktop-pic-commodity-largepic-sample-general.png": "ad9e04fa08a789be9e90aa0340f6c9f5",
"assets/assets/3.0x/desktop-icon-arrowdown-double.png": "ebe43ea0439dfa21fc399bf4b88e1c42",
"assets/assets/3.0x/desktop-pic-nft-instruction-12.png": "cfa42c6bc25d8d74c096a2707b54128b",
"assets/assets/3.0x/pic-animation-qpp.png": "2b6579ea3db696a3ac659e61719d58e1",
"assets/assets/3.0x/mobile-icon-article-respond-normal.png": "749f3d59f801992884bc5c80dbb876d5",
"assets/assets/3.0x/desktop-pic-qpp-logo-03.png": "b3dd3c4b2edd0820ef5ca15e8ce4ffd9",
"assets/assets/3.0x/mobile-icon-actionbar-search-normal.png": "6a52f9f0e16b03862fe9600dbf223a7e",
"assets/assets/3.0x/desktop-icon-selection-arrow-right-normal.png": "2a24ea5d7d2f298cd5624c12bab5736e",
"assets/assets/3.0x/mobile-icon-article-respond-pressed.png": "4793d76d8d8bbb81060d96c1eb046020",
"assets/assets/3.0x/desktop-pic-qpp-text.png": "9bcb91a86e8a0519cd49a68c4a2e426b",
"assets/assets/3.0x/desktop-pic-nft-instruction-17.png": "7af87347f570378438b820c49ce35983",
"assets/assets/3.0x/desktop-icon-area-01-03-pressed.png": "2da2d6faa784014f3f0314b971f16125",
"assets/assets/3.0x/mobile-pic-avatar-default-normal.png": "f7b299d328e069532d18e5e8016ea3cb",
"assets/assets/3.0x/desktop-icon-official-normal.png": "765f9d9386ea4c286c96f19f020ad589",
"assets/assets/3.0x/mobile-icon-newsfeed-article-switch.png": "ac0742a6cad03580619e98a0a152dd1b",
"assets/assets/3.0x/mobile-pic-area-02-03.png": "4301972b514f18ae8d8e6c699871c2e9",
"assets/assets/3.0x/desktop-pic-nft-instruction-14.png": "cf82d579a929684d3ff5cbe24816d998",
"assets/assets/3.0x/mobile-icon-article-like-pressed.png": "4c222d3fe0b4e9c64584cd19627402ac",
"assets/assets/3.0x/desktop-pic-nft-instruction-18.png": "82853eb8843b036caa4f5268bb3e30c9",
"assets/assets/3.0x/mobile-icon-actionbar-list-normal.png": "8dcf5b6c8c3e135736a7617fcbe36689",
"assets/assets/3.0x/mobile-icon-article-function-pressed.png": "fffefe28db2c0f612661136ba02eda9d",
"assets/assets/3.0x/icon-display-ticket.png": "69a51be9e67e7137f485c27c132d039d",
"assets/assets/3.0x/icon-display-scratch-card-serial-number.png": "db493c771dc7f1dfb42bf192204e39ed",
"assets/assets/3.0x/desktop_pic_profile_avatar_default.png": "a9811f4200df6f6be5089e67084256ba",
"assets/assets/3.0x/desktop-pic-nft-instruction-05.png": "fe02e916ea96522cfba5aa0a3ad31da2",
"assets/assets/3.0x/desktop-icon-area-04-official.png": "16b75191019bfeedbdc06fffbdb85f28",
"assets/assets/3.0x/desktop-pic-nft-instruction-08.png": "93779e3128780a335fd23329bf1dae46",
"assets/assets/3.0x/desktop-pic-nft-instruction-21.png": "36de91744baa6e2d3482f454b0d9e1fe",
"assets/assets/3.0x/desktop-icon-list-selection-arrow-up.png": "ef083cbdf980dd88fab48fd60f19e9fb",
"assets/assets/3.0x/mobile-icon-actionbar-list-logout-pressed.png": "e8214efd12ec83ad100cd8da0247a9b8",
"assets/assets/3.0x/mobile-icon-newsfeed-post-addpic-disable.png": "25c25ac7a77b6bd0176f057bc8fcd02c",
"assets/assets/3.0x/mobile-bg-area-01.png": "63a3aead75b8acd8f54f9d594244ada8",
"assets/assets/3.0x/desktop-icon-area-01-02-pressed.png": "8ce667446d6be4577615db7ffe08849d",
"assets/assets/3.0x/desktop-image-qpp-logo-01.png": "0d3fec167dc02ac32361125ff5b78175",
"assets/assets/3.0x/mobile-icon-newsfeed-article-privacy.png": "a036da13abfd36e06eb5859b44114b79",
"assets/assets/3.0x/desktop-bg-area-03-box.png": "66ad0fb981c71644a00882802d6773c2",
"assets/assets/3.0x/mobile-icon-article-like-normal.png": "502768364466d70d4190bf1e0f757937",
"assets/assets/3.0x/desktop-pic-nft-instruction-01.png": "c98b775638fa6e5356ff3b66113e7ac5",
"assets/assets/3.0x/icon-display-idcard.png": "d74759d45b442de2a78da56e6dae9bf5",
"assets/assets/3.0x/desktop-icon-display-scratch-card-qr-code.png": "28260aa757a3177ce5e3f98baca7feab",
"assets/assets/3.0x/icon-display-questionnaire.png": "8a9f774d92bbd0fade5c075fe472044d",
"assets/assets/3.0x/mobile-icon-respond-send-normal.png": "0f4b44c6c4addf8e1c5e85ac4dd2c75c",
"assets/assets/3.0x/mobile-icon-actionbar-language-pressed.png": "8a124bda076fe40814c1ea4ccb4cd752",
"assets/assets/3.0x/mobile-icon-actionbar-profile-pressed.png": "04be31f62a2b050854179c79760e531a",
"assets/assets/3.0x/desktop-icon-commodity-nft-describe.png": "ffb65bd0b2307003fa1fbc838325f378",
"assets/assets/3.0x/icon-display-treasure.png": "c03ceb8f347d9213634c6d1d0c72daca",
"assets/assets/3.0x/desktop-bg-area-01.png": "a4e96486f2eb8b1a19a75d49133df47a",
"assets/assets/3.0x/mobile-icon-respond-like-pressed.png": "992416decc0bd2b9b11fa02f2cb66462",
"assets/assets/3.0x/mobile-icon-newsfeed-featurelist-report-pressed.png": "d530ba60417ec2fd2a23e4c112b8ae1b",
"assets/assets/3.0x/mobile-pic-area-02-02.png": "6a60387dd066a60ab0f3c562d9a989e8",
"assets/assets/3.0x/mobile-icon-menu-arrow-down.png": "592a4a4feded52a041ffc85afca4203c",
"assets/assets/3.0x/desktop-pic-platform-googleplay.png": "6f6c114df5e9880a895b2750169f2b8f",
"assets/assets/3.0x/mobile-icon-article-function-normal.png": "0a1bfaf8b0da60ba0133be938d6bc888",
"assets/assets/3.0x/desktop-icon-area-01-02-nomal.png": "3bb2fd5f73b9db21c77e7df7ccf3e6ef",
"assets/assets/3.0x/desktop-icon-commodity-nft-levels.png": "e9cda3617b3be85c594b2416c199f4b9",
"assets/assets/3.0x/desktop-icon-newsfeed-pic-delete.png": "196defd59a9493c249aba3d029829c8e",
"assets/assets/3.0x/mobile-icon-dialog-delete-normal.png": "b9bb7c0c742e308129c0daecde7b979f",
"assets/assets/3.0x/desktop-pic-nft-instruction-13.png": "9eba86ebfd2341072ff6bedfb5943709",
"assets/assets/3.0x/mobile-icon-share-line-normal.png": "4a7d6b2b367fa4ed03c95a4aa4180c9d",
"assets/assets/3.0x/desktop-icon-reorganize.png": "66f828120d1dba77a7347cefd31ed0c0",
"assets/assets/3.0x/desktop-icon-button-check-default.png": "1dff11c7fbc328fcfb05f8b1a8903fdd",
"assets/assets/3.0x/mobile-icon-share-facebook-normal.png": "3e187be5155f206cb0f44cde9ad26b4d",
"assets/assets/3.0x/mobile-icon-newsfeed-article-public.png": "e5083a0c3e8209f3199c2f69ee7d1f23",
"assets/assets/3.0x/desktop-pic-nft-instruction-02.png": "85fcf694246d35fa1bcab834f4f2ac6d",
"assets/assets/3.0x/desktop-pic-nft-instruction-04.png": "3219ae7e775687a15fe721a08ff48fab",
"assets/assets/3.0x/desktop-image-newsfeed-avatar-medium.png": "c6b812e538dfc48f9d8bbf77724983d6",
"assets/assets/3.0x/mobile-icon-actionbar-list-notice-pressed.png": "b0ea54f71faceee1cf0494b3eee9867f",
"assets/assets/3.0x/desktop-icon-commodity-nft-date.png": "8d9c72f960803cb6fd35c30b6858b9d8",
"assets/assets/3.0x/mobile-icon-actionbar-language-normal.png": "f453a71bc35ba70d32f60520b920c54b",
"assets/assets/3.0x/pic-animation-icon.png": "22ca6a0aaddac54a0ce10a49e671a1a6",
"assets/assets/3.0x/mobile-icon-redpoint.png": "44be205c7ceac1bbbd576cd98ffe2173",
"assets/assets/3.0x/desktop-icon-area-01-03-normal.png": "253d147dc47d27f4a21808129baa5bd0",
"assets/assets/3.0x/mobile-icon-actionbar-list-profile-pressed.png": "2bed1e52742191ae7953dafb99593d41",
"assets/assets/3.0x/icon-display-treasure-tag.png": "ee039b9c190b102c49ab3de45387f20b",
"assets/assets/3.0x/desktop-pic-nft-instruction-06.png": "2df39235c09d4c5f4fce052a24198560",
"assets/assets/3.0x/icon-commoditylist-edit-normal.png": "9df8c17c0ac421b5e21ad9a64a8da8d4",
"assets/assets/3.0x/desktop-icon-dialog-delete-normal.png": "387e24c6612810d47f843b420010f7b9",
"assets/assets/3.0x/icon-commoditylist-trash-in-normal.png": "129d894ce91ab35a594de8e0fe563859",
"assets/assets/3.0x/desktop-pic-area-01.png": "48c9f990b2a04d3bf8e6c8cdb4107cd4",
"assets/assets/3.0x/mobile-icon-respond-like-normal.png": "4daee84b5969dc18340ca7fc2762a5be",
"assets/assets/3.0x/mobile-icon-actionbar-list-profile-normal.png": "c2833c0b1d54ed928e306c57ef24e6f3",
"assets/assets/3.0x/desktop-pic-nft-instruction-16.png": "3c305a07db848bb77971b6ba1da4baf7",
"assets/assets/3.0x/desktop-icon-area-01-01-normal.png": "648dec94e6341bac74c3a4b0f09b86bc",
"assets/assets/3.0x/mobile-icon-actionbar-list-notice-alert-pressed.png": "c2b695ae6b3d9c374819ae0b30b35bc7",
"assets/assets/3.0x/mobile-pic-qpp-logo-03.png": "a8b93a45e38f6d6e4eaeb98d7a5cb400",
"assets/assets/3.0x/icon-selection-arrow-more-normal.png": "e02f0d8a1edda2a9dc40f7dc177be819",
"assets/assets/3.0x/desktop-pic-kv.png": "78e776198be4a7fe313c9236f7bc69fa",
"assets/assets/3.0x/mobile-bg-kv_2.png": "935d849cd2038ce936846b57c3ab916c",
"assets/assets/3.0x/mobile-bg-kv.png": "4e6b30c6740a8703231040e307e14e66",
"assets/assets/3.0x/desktop-icon-commodity-nft-stats.png": "1e1f8f2b115babb4887cdc0d580943b1",
"assets/assets/3.0x/mobile-icon-newfeed-notfound.png": "d9856f13c2cca71db7cee09b96ad7dd1",
"assets/assets/3.0x/icon-actionbar-notice-alert-normal.png": "7373a33dab007feb7bb61adfa46790ac",
"assets/assets/3.0x/desktop-pic-nft-instruction-19.png": "ead35e1f5c9e73f19cedc436bd8432a2",
"assets/assets/3.0x/pic-empty-default.png": "2fb98952e8a86b45c45bde3f3a923d9c",
"assets/assets/desktop-image-newsfeed-avatar-medium.png": "9ea7ff4d2fa3162f224b7f1942986d14",
"assets/assets/mobile-icon-actionbar-list-notice-pressed.png": "9ce6a284b5200c656e94f29745a85441",
"assets/assets/desktop-icon-commodity-nft-date.png": "1d4169c1b909a871ff1462aae0d8316f",
"assets/assets/mobile-icon-actionbar-language-normal.png": "c3fde565ec2a54e067ee516e91a2a7eb",
"assets/assets/pic-animation-icon.png": "b93afc11d5c23482a6ebe0389bfb38c9",
"assets/assets/desktop-bg-kv.png": "59816fc0520ff1fdb2fb5cea0e6d9160",
"assets/assets/mobile-icon-redpoint.png": "0b26962466fbd1dbe8590b62437fba04",
"assets/assets/desktop-icon-area-01-03-normal.png": "d03af941b1fc591f5e94fadd9311240e",
"assets/assets/mobile-icon-actionbar-list-profile-pressed.png": "866fde49c0a16e840de1743d26f54d1d",
"assets/assets/icon-display-treasure-tag.png": "95587be325aff7230cfd51cfed97c05a",
"assets/assets/desktop-pic-nft-instruction-06.png": "1c69435ba845da1b60a9f9395dd6d431",
"assets/assets/icon-commoditylist-edit-normal.png": "19ab972ab5e6ed8a3b4523f02a04873e",
"assets/assets/desktop-icon-dialog-delete-normal.png": "d8690e881cbc5ede9e181cead3f7c7f1",
"assets/assets/icon-commoditylist-trash-in-normal.png": "643f68e1f34edef419230e440f61d112",
"assets/assets/desktop-pic-area-01.png": "81863f033f590c4eee9bb7d2c82fe9fb",
"assets/assets/mobile-icon-respond-like-normal.png": "507f3ca9403be5b419f644515482f97d",
"assets/assets/mobile-icon-actionbar-list-profile-normal.png": "ba2d61fe37bbca53684b154d5ed63c6e",
"assets/assets/desktop-pic-nft-instruction-16.png": "d8b29aa45431b7273b3ce2dcb83a1bd9",
"assets/assets/desktop-icon-area-01-01-normal.png": "1f0ea5551a39a74974d12ba4e589efc9",
"assets/assets/mobile-icon-actionbar-list-notice-alert-pressed.png": "6e5e2783671e7e694d58f60aa6f1e0eb",
"assets/assets/mobile-pic-qpp-logo-03.png": "cb3e7e2b929cfbacf65944d71915f785",
"assets/assets/icon-selection-arrow-more-normal.png": "f8d4640a13746cdc54bff6bd40f168f7",
"assets/assets/desktop-pic-kv.png": "b1209074c4fafb5a9f779b68d8975c67",
"assets/assets/pic-animation-icon-2.png": "b93afc11d5c23482a6ebe0389bfb38c9",
"assets/assets/mobile-bg-kv_2.png": "556d6f5976227fb42b185270ca8d6764",
"assets/assets/desktop-pic-area-02-02.png": "e192bdf26b17324f76f6d0455a4d83dd",
"assets/assets/mobile-bg-kv.png": "5e7db4fb2b1fb8545d2a137fd8332651",
"assets/assets/desktop-icon-commodity-nft-stats.png": "c08f60de92f1895bfd5eed54f2b2440a",
"assets/assets/mobile-icon-newfeed-notfound.png": "7ad3d31dbd26794d257391cd2a7d411f",
"assets/assets/icon-actionbar-notice-alert-normal.png": "0ee1a2f98ab1b4656cdc90171994a18a",
"assets/assets/desktop-pic-nft-instruction-19.png": "48559b8995ad75b87674c012569656a5",
"assets/assets/pic-empty-default.png": "33959ae064f3c8b31b81189380aea5ee",
"assets/AssetManifest.bin": "4ea11d8e11c01c1d9646b8e94eed92c5",
"assets/NOTICES": "bcf4e619d628f98f233dd8458d656909",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.json": "ace97cc3f0212cdc4f204b028a4dbe43",
"version.json": "56f24fd90e44b17e54e0681e894612bb",
"icons/Icon-512.png": "344f49d76430000d8be7f86765e13d3d",
"icons/Icon-maskable-192.png": "290629307d6889c2dae3e8b2eed4a9fa",
"icons/Icon-maskable-512.png": "344f49d76430000d8be7f86765e13d3d",
"icons/Icon-192.png": "290629307d6889c2dae3e8b2eed4a9fa",
"manifest.json": "7eef344d26cc5e1da93c9544741975b1",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"main.dart.js": "8f43950898b4dcb082d8c2eb249bafc0"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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

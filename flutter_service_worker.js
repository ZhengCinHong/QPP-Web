'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"manifest.json": "7eef344d26cc5e1da93c9544741975b1",
"index.html": "e420d38c61e13aa3ff333264f879baa1",
"/": "e420d38c61e13aa3ff333264f879baa1",
"assets/AssetManifest.bin": "d1d35d74ca3bbc1bcc97961f47a8721f",
"assets/assets/mobile-pic-avatar-default-normal.png": "b08c8da6f13e79f6b0caf27e10894f58",
"assets/assets/mobile-icon-menu-arrow-up.png": "8a9ccb5a472dad26659298320a8129e2",
"assets/assets/mobile-icon-actionbar-search-normal.png": "b9fbdceb8c9e1ea732914958aa7f1aad",
"assets/assets/mobile-icon-share-copylink-normal.png": "6942307e4051e21dec35206378b08605",
"assets/assets/mobile-icon-actionbar-language-pressed.png": "1e61c95a8cad8582a4bfb5827c5f1a7e",
"assets/assets/desktop-icon-commodity-nft-levels.png": "daf5f8b39923f6b67885e377e87f0cd9",
"assets/assets/desktop-pic-nft-instruction-18.png": "3d215f4bb6e7babf3f9858fd91b3ce70",
"assets/assets/desktop-icon-list-selection-arrow-up.png": "dd648775ce6e26fd40c54c6ee6ec9b53",
"assets/assets/desktop-image-newsfeed-avatar-medium.png": "9ea7ff4d2fa3162f224b7f1942986d14",
"assets/assets/mobile-icon-respond-function-normal.png": "dd85b4d25d096ba73f182201d0350662",
"assets/assets/desktop-pic-nft-instruction-14.png": "f9983b6c664ddcfb74ac5772fa46a295",
"assets/assets/desktop-icon-area-01-02-nomal.png": "56942925c5e5619db01900850193d3ad",
"assets/assets/mobile-icon-newsfeed-article-switch.png": "2c3ade18704229aa7bf96c113d5bb90b",
"assets/assets/desktop-icon-area-01-01-pressed.png": "3b548ce7dba05d78fe6ac4e5ad001b0c",
"assets/assets/desktop-pic-platform-googleplay.png": "4334600ac2a2cc3b0f76b6c406c4d894",
"assets/assets/desktop-icon-commodity-nft-boosts.png": "20e7fcf1eb9bd5549d2ac9ec04264944",
"assets/assets/mobile-icon-actionbar-list-logout-normal.png": "d86bd4a238c3b6bcef0ff2e647d3fe85",
"assets/assets/icon-bluepoint.png": "7df4e327a7a9b995788fcb3ab71e25df",
"assets/assets/desktop-pic-nft-instruction-08.png": "92faf5a5e636427d5cb50a1272ceb605",
"assets/assets/desktop-icon-selection-arrow-right-normal.png": "d6442beadff421b30653e61b4dc1526b",
"assets/assets/desktop-icon-area-01-01-normal.png": "1f0ea5551a39a74974d12ba4e589efc9",
"assets/assets/desktop-bg-area-03-box.png": "431f38669a0b71fe61382386e40ddcff",
"assets/assets/desktop-pic-nft-instruction-20.png": "f5345d1bac412e0f93e6020f23b0eb0d",
"assets/assets/mobile-icon-share-line-normal.png": "738b6531ac9a35e0178363c6e75f23a1",
"assets/assets/mobile-icon-article-like-normal.png": "88d1786d890c86379882740364b1ddd3",
"assets/assets/desktop-pic-nft-instruction-05.png": "405ae244f79c6484f0e079b7ca30787b",
"assets/assets/desktop_pic_profile_avatar_default.png": "2744679a0218068a98eaa7747b26e21c",
"assets/assets/desktop-pic-nft-instruction-17.png": "80b9717d1064980cb6ac712f8ae19058",
"assets/assets/desktop-pic-area-02-03.png": "2960a700ad1f2106c60b0f0c066c49ed",
"assets/assets/mobile-pic-area-02-02.png": "8c8203ff2a93e2d14f25790de562f06f",
"assets/assets/desktop-icon-arrowdown-double.png": "f9b60bfafeda14fcd7432237a65f143f",
"assets/assets/mobile-icon-respond-like-pressed.png": "b8a376b66d580908f6f6ef795d8f3f9e",
"assets/assets/icon-display-treasure.png": "9dc0f3d78811249ddae8b3e16d1eacea",
"assets/assets/desktop-icon-button-check-single.png": "dd2924b2c2ac2f43befc397ab2609c14",
"assets/assets/desktop-pic-commodity-largepic-sample-general.png": "a8f2807d6aae86e451dbc184957b8cbc",
"assets/assets/icon-display-ticket.png": "e4a1392c310289d38664618fcac0598c",
"assets/assets/desktop-pic-kv.png": "b1209074c4fafb5a9f779b68d8975c67",
"assets/assets/3.0x/desktop-pic-nft-instruction-18.png": "82853eb8843b036caa4f5268bb3e30c9",
"assets/assets/3.0x/desktop-pic-nft-instruction-14.png": "cf82d579a929684d3ff5cbe24816d998",
"assets/assets/3.0x/desktop-pic-nft-instruction-08.png": "93779e3128780a335fd23329bf1dae46",
"assets/assets/3.0x/desktop-pic-nft-instruction-20.png": "04a042eece472750ea11f750b9a3e659",
"assets/assets/3.0x/desktop-pic-nft-instruction-05.png": "fe02e916ea96522cfba5aa0a3ad31da2",
"assets/assets/3.0x/desktop_pic_profile_avatar_default.png": "a9811f4200df6f6be5089e67084256ba",
"assets/assets/3.0x/desktop-pic-nft-instruction-17.png": "7af87347f570378438b820c49ce35983",
"assets/assets/3.0x/desktop-pic-commodity-largepic-sample-general.png": "ad9e04fa08a789be9e90aa0340f6c9f5",
"assets/assets/3.0x/desktop-pic-kv.png": "78e776198be4a7fe313c9236f7bc69fa",
"assets/assets/3.0x/desktop-pic-nft-instruction-24.png": "b2a95f2278864b4a1f417c5ca6e1f9a7",
"assets/assets/3.0x/desktop-pic-nft-instruction-02.png": "85fcf694246d35fa1bcab834f4f2ac6d",
"assets/assets/3.0x/desktop-pic-nft-instruction-16.png": "3c305a07db848bb77971b6ba1da4baf7",
"assets/assets/3.0x/desktop-pic-nft-instruction-19.png": "ead35e1f5c9e73f19cedc436bd8432a2",
"assets/assets/3.0x/mobile-icon-actionbar-list-pressed.png": "76d124bf9669fd2150d41912213426b5",
"assets/assets/3.0x/desktop-pic-nft-instruction-21.png": "36de91744baa6e2d3482f454b0d9e1fe",
"assets/assets/3.0x/desktop-bg-area-03.png": "ee7070082fda0c75a7faeead3cc9bff5",
"assets/assets/3.0x/desktop-bg-kv-2.png": "43022c5e47979cbfe63b864a4e5e66d8",
"assets/assets/3.0x/desktop-pic-commodity-avatar-default.png": "4cd3e1a844868acd9bb573623b7437e2",
"assets/assets/3.0x/desktop-pic-nft-instruction-12.png": "cfa42c6bc25d8d74c096a2707b54128b",
"assets/assets/3.0x/desktop-pic-nft-instruction-03.png": "646feda9545ff2785eb6b739b074c794",
"assets/assets/3.0x/mobile-bg-kv.png": "4e6b30c6740a8703231040e307e14e66",
"assets/assets/3.0x/desktop-pic-nft-instruction-13.png": "9eba86ebfd2341072ff6bedfb5943709",
"assets/assets/3.0x/desktop-icon-display-scratch-card-qr-code.png": "28260aa757a3177ce5e3f98baca7feab",
"assets/assets/3.0x/desktop-pic-nft-instruction-15.png": "6a866fff2afbb63c43eb215de82c64fc",
"assets/assets/3.0x/desktop-pic-nft-instruction-11.png": "62604b5d468e7f845a2872a93fcc1b3c",
"assets/assets/3.0x/desktop-pic-nft-instruction-10.png": "8b29ad45cf1732a05b5e02effc60286b",
"assets/assets/3.0x/desktop-pic-nft-instruction-06.png": "2df39235c09d4c5f4fce052a24198560",
"assets/assets/3.0x/desktop-pic-nft-instruction-07.png": "d66a34e5205a6adec6de6d40f48ceb98",
"assets/assets/3.0x/desktop-pic-nft-instruction-22.png": "5a06dc62193af5cde6519671fbd8474f",
"assets/assets/3.0x/desktop-pic-nft-instruction-09.png": "68e63c0d1c42060843c464acf753e5a5",
"assets/assets/3.0x/desktop-pic-nft-instruction-23.png": "8fe0a2f0b737665ab6becff5e1ef5720",
"assets/assets/3.0x/desktop-pic-qpp-text.png": "9bcb91a86e8a0519cd49a68c4a2e426b",
"assets/assets/3.0x/desktop-pic-nft-instruction-04.png": "3219ae7e775687a15fe721a08ff48fab",
"assets/assets/3.0x/desktop-pic-nft-instruction-01.png": "c98b775638fa6e5356ff3b66113e7ac5",
"assets/assets/3.0x/mobile-bg-area-03.png": "6136058dd48a28389c743752b2dabdb2",
"assets/assets/3.0x/icon-display-digital-object.png": "9ebb0c0d70721678bf359f1bb420bd30",
"assets/assets/3.0x/bg-dialog.png": "1062a6e128c690fbffa0b705f8195001",
"assets/assets/3.0x/mobile-icon-actionbar-close-normal.png": "8a2865502059ec99a3da5b2ae2c4fb98",
"assets/assets/3.0x/mobile-icon-actionbar-list-normal.png": "8dcf5b6c8c3e135736a7617fcbe36689",
"assets/assets/icon-display-scratch-card-serial-number.png": "83ac7dd71f106984334478b19f5dffb2",
"assets/assets/desktop-pic-nft-instruction-24.png": "ce1b267fa0dcd2ac1ce5e92979a759b8",
"assets/assets/mobile-icon-newsfeed-article-privacy.png": "55881e9a041d8046af0ad90703a050bd",
"assets/assets/desktop-pic-area-02-02.png": "e192bdf26b17324f76f6d0455a4d83dd",
"assets/assets/mobile-icon-respond-like-normal.png": "507f3ca9403be5b419f644515482f97d",
"assets/assets/desktop-icon-area-01-03-pressed.png": "92a49c25996b4feb689705e383e226f7",
"assets/assets/desktop-icon-official-normal.png": "7760c8e0df51f63ff56d12b92ee0e4ad",
"assets/assets/desktop-icon-commodity-nft-date.png": "1d4169c1b909a871ff1462aae0d8316f",
"assets/assets/icon-display-idcard.png": "7f2bd3e32243e47375945263a641ae10",
"assets/assets/mobile-pic-area-02-01.png": "91245c6fb8c3d89e546ea78582f41255",
"assets/assets/icon-display-coin.png": "758030650a9b2af89fc67e14eae36a44",
"assets/assets/desktop-pic-nft-instruction-02.png": "700e847d685baa1001a965bac8c85eea",
"assets/assets/mobile-icon-article-like-pressed.png": "91f5975baf9356d3d1d0953bf54bab14",
"assets/assets/mobile-icon-actionbar-profile-login-default.png": "8f302327639888f4c667ab51808203ff",
"assets/assets/desktop-pic-nft-instruction-16.png": "d8b29aa45431b7273b3ce2dcb83a1bd9",
"assets/assets/desktop-icon-commodity-nft-describe.png": "c2d07e080fc58b4a5a613b72c86c00ac",
"assets/assets/desktop-image-qpp-text.png": "f3e48b14e83ed4e0a7ca3a2f73db49ce",
"assets/assets/desktop-icon-area-01-04-pressed.png": "86f50d3d9b2807f5db23e6720a54652d",
"assets/assets/pic-fail.png": "1abf2454318a3c6c505227a05d487e58",
"assets/assets/mobile-icon-share-facebook-normal.png": "77e799a4b77fc1d4f353a84139ebb58c",
"assets/assets/mobile-icon-actionbar-profile-normal.png": "ac2a12b454c3cced7ea7370027c0e0dc",
"assets/assets/icon-commoditylist-edit-normal.png": "19ab972ab5e6ed8a3b4523f02a04873e",
"assets/assets/desktop-icon-dialog-delete-normal.png": "d8690e881cbc5ede9e181cead3f7c7f1",
"assets/assets/mobile-icon-actionbar-search-pressed.png": "b20ee0a63bf7c9a939407d6fb3c807b1",
"assets/assets/desktop-icon-list-selection-arrow-down.png": "2e8290b189ae4e3ca6fbbfd6a50dbbb7",
"assets/assets/desktop-pic-nft-instruction-19.png": "48559b8995ad75b87674c012569656a5",
"assets/assets/pic-animation-icon.png": "0779870e0631e939f0c163de78855e77",
"assets/assets/mobile-icon-dialog-delete-normal.png": "89d546a3cb89a44b0c87b50f92d0f9bf",
"assets/assets/mobile-icon-actionbar-list-pressed.png": "e645b04284c9dc7346584e1bc56952a5",
"assets/assets/mobile-icon-actionbar-list-notice-alert-pressed.png": "6e5e2783671e7e694d58f60aa6f1e0eb",
"assets/assets/desktop-pic-nft-instruction-21.png": "40f27e00ac9f9fd5f4cdf3785a9eb404",
"assets/assets/desktop-icon-area-01-02-pressed.png": "a24753b1daaada4eccca540cb81c4916",
"assets/assets/icon-selection-arrow-more-normal.png": "f8d4640a13746cdc54bff6bd40f168f7",
"assets/assets/mobile-icon-newfeed-notfound.png": "7ad3d31dbd26794d257391cd2a7d411f",
"assets/assets/desktop-pic-qpp-logo-03.png": "7ff444862e5a78a286911a2f5887a2d7",
"assets/assets/mobile-icon-newsfeed-featurelist-report-pressed.png": "fabe8c6206ef0e29338c0a2fb9e01cb8",
"assets/assets/mobile-bg-area-01.png": "2ae49dc13ab892c668126f3492020919",
"assets/assets/mobile-image-newsfeed-avatar-hashtag.png": "4d4fa6987568f221af1d9add48678dde",
"assets/assets/langs/langs.csv": "298ec55dc9d02ca2c9ccd92264a7369d",
"assets/assets/desktop-bg-area-03.png": "f63948060d9fe51844bb8b6fc2e5e4d1",
"assets/assets/desktop-bg-kv-2.png": "b7567c82b9b16e6663d01af6a1b73511",
"assets/assets/desktop-pic-commodity-avatar-default.png": "e9c1bb69c88fee03475d0d37de5abc7f",
"assets/assets/desktop-pic-nft-instruction-12.png": "8b6912957b02bac0c5b5d81273768538",
"assets/assets/icon-display-questionnaire.png": "9f55ce99f9e54bfac80962b960618bda",
"assets/assets/desktop-icon-button-check-default.png": "1da15db2da22bf022714f1cb1e1693f7",
"assets/assets/icon-commoditylist-trash-in-normal.png": "643f68e1f34edef419230e440f61d112",
"assets/assets/desktop-pic-nft-instruction-03.png": "f2d5e2b2cdad06521dfb679511e6ecb8",
"assets/assets/mobile-icon-article-function-pressed.png": "25998c2cf89e057a1a08afd1df4ab480",
"assets/assets/mobile-icon-newsfeed-post-addpic-disable.png": "f63dccb5c62ab61f0edd08e5bc689505",
"assets/assets/desktop-bg-area-01.png": "63d4e254d26bfe0f63af651df8c4791a",
"assets/assets/pic-animation-icon-2.png": "b93afc11d5c23482a6ebe0389bfb38c9",
"assets/assets/mobile-icon-article-share-pressed.png": "10b0c590169b455df408bbb86a7b6ef4",
"assets/assets/mobile-icon-actionbar-list-profile-normal.png": "ba2d61fe37bbca53684b154d5ed63c6e",
"assets/assets/pic-animation-qpp.png": "b684133832be8565deb3888a1da64d03",
"assets/assets/mobile-icon-menu-arrow-down.png": "c31464da48ca6f06d4b68140f0a1c5bd",
"assets/assets/mobile-icon-newsfeed-featurelist-report-normal.png": "8ebdd14048fdf15c361cc6b3ea3ead18",
"assets/assets/mobile-icon-redpoint.png": "0b26962466fbd1dbe8590b62437fba04",
"assets/assets/mobile-icon-actionbar-profile-normal-2.png": "ac2a12b454c3cced7ea7370027c0e0dc",
"assets/assets/desktop-bg-kv.png": "59816fc0520ff1fdb2fb5cea0e6d9160",
"assets/assets/mobile-icon-actionbar-list-logout-pressed.png": "588936f7dcd646d66fe20640bd63b4bf",
"assets/assets/mobile-bg-kv.png": "5e7db4fb2b1fb8545d2a137fd8332651",
"assets/assets/pic-qrcode.png": "125afdb0fb03c6cf25a4202279c0fc0b",
"assets/assets/desktop-pic-nft-instruction-13.png": "809da05cd57610379b86b62be99323ca",
"assets/assets/desktop-icon-area-04-official.png": "06ea234afe79a8eee61ec3af2f861f33",
"assets/assets/icon-actionbar-notice-alert-normal.png": "0ee1a2f98ab1b4656cdc90171994a18a",
"assets/assets/mobile-icon-article-function-normal.png": "521b52ab63602eafb71173b613fc7164",
"assets/assets/desktop-icon-display-scratch-card-qr-code.png": "a65d86072ab2ecc2dbfbc9d3370de10e",
"assets/assets/desktop-pic-nft-instruction-15.png": "7ec2ca8f1f56c1342ebea2663d2d342b",
"assets/assets/2.0x/desktop-pic-nft-instruction-18.png": "70f30f5412d405f80dc7a004bb04acf1",
"assets/assets/2.0x/desktop-pic-nft-instruction-14.png": "afcd5e2ceffe8b4ae8f55c50ce6de326",
"assets/assets/2.0x/desktop-pic-nft-instruction-08.png": "e6b311878eb09aca4be7da19d3ad838d",
"assets/assets/2.0x/desktop-pic-nft-instruction-20.png": "e5bed28cd47376b87b4c36817b098522",
"assets/assets/2.0x/desktop-pic-nft-instruction-05.png": "75c00e29e367926febf3926b9684390a",
"assets/assets/2.0x/desktop_pic_profile_avatar_default.png": "08004e866aadac6615eec52ed9433fda",
"assets/assets/2.0x/desktop-pic-nft-instruction-17.png": "f5c72235ca53dec6584b97916307e94a",
"assets/assets/2.0x/desktop-pic-commodity-largepic-sample-general.png": "c23d24133b91965d4670a997dfa678b3",
"assets/assets/2.0x/desktop-pic-kv.png": "8331f3b96642a2453b1533f9d24b46a8",
"assets/assets/2.0x/desktop-pic-nft-instruction-24.png": "e21bcf46dc40424d6ce905bed37fdc6a",
"assets/assets/2.0x/desktop-pic-nft-instruction-02.png": "931ecde52f8980e84564aa85ddf35812",
"assets/assets/2.0x/desktop-pic-nft-instruction-16.png": "50f1c07f38e6a56014c09a22d3fc1f6e",
"assets/assets/2.0x/desktop-pic-nft-instruction-19.png": "99e8c5e601496830bc77057f037466e9",
"assets/assets/2.0x/mobile-icon-actionbar-list-pressed.png": "f5d107799de90b1aa54c1dfa859a240c",
"assets/assets/2.0x/desktop-pic-nft-instruction-21.png": "9e892e87d43ab0aefe435a00c5093482",
"assets/assets/2.0x/desktop-bg-area-03.png": "25e4c5ff3f2a0c9cb64588e98848e798",
"assets/assets/2.0x/desktop-bg-kv-2.png": "34308f77dcfbe84ceafb06731c3344a2",
"assets/assets/2.0x/desktop-pic-commodity-avatar-default.png": "4feb1374fc51a13e399ec9b8aa3fbeb3",
"assets/assets/2.0x/desktop-pic-nft-instruction-12.png": "5df0cbf455e5f3e408f7b073003505a8",
"assets/assets/2.0x/desktop-pic-nft-instruction-03.png": "89f4314529b3ac099ca1fd34b992c06f",
"assets/assets/2.0x/mobile-bg-kv.png": "3c98f195b0ca293d28fcb02b82eaa7bd",
"assets/assets/2.0x/desktop-pic-nft-instruction-13.png": "c907899a1ead29f848ba991a8e8ba874",
"assets/assets/2.0x/desktop-icon-display-scratch-card-qr-code.png": "06820864cd8b023d618e8d154ff5ed70",
"assets/assets/2.0x/desktop-pic-nft-instruction-15.png": "0f83542a7fbd0b2e29a39356c180fe1d",
"assets/assets/2.0x/desktop-pic-nft-instruction-11.png": "1d4214c23898d0d29df201865b3252fc",
"assets/assets/2.0x/desktop-pic-nft-instruction-10.png": "e9c90dac9fac2dd006edcdb63fce76c9",
"assets/assets/2.0x/desktop-pic-nft-instruction-06.png": "b0a6f8361bc24487048f0c460d96ab54",
"assets/assets/2.0x/desktop-pic-nft-instruction-07.png": "35f6275f39dad8c7ca4764f14437a0a3",
"assets/assets/2.0x/desktop-pic-nft-instruction-22.png": "801cb7db8ffcff8ec45c7cb955d98cdd",
"assets/assets/2.0x/desktop-pic-nft-instruction-09.png": "53ebe51d365e1bb1695108da4583c22d",
"assets/assets/2.0x/desktop-pic-nft-instruction-23.png": "fdffdeaae0ab656365b974fe9c4f2529",
"assets/assets/2.0x/desktop-pic-qpp-text.png": "5125fe7818520363e2c635b140c16861",
"assets/assets/2.0x/desktop-pic-nft-instruction-04.png": "1cf2b458fa694bb8fdddb5f9611e97d6",
"assets/assets/2.0x/desktop-pic-nft-instruction-01.png": "7163a2571415024fee766d43cdacf084",
"assets/assets/2.0x/mobile-bg-area-03.png": "73e011c14ff1bca22ba2a3846f1ab671",
"assets/assets/2.0x/icon-display-digital-object.png": "aeca807a25000d532861fe21aa341ca9",
"assets/assets/2.0x/bg-dialog.png": "90a84a6c8543de8effbb8613400044c0",
"assets/assets/2.0x/mobile-icon-actionbar-close-normal.png": "c8a1af43353a51a19e180e006c3f6b09",
"assets/assets/2.0x/mobile-icon-actionbar-list-normal.png": "59c39eddb062def4fff1f480bebfc0ce",
"assets/assets/desktop-pic-nft-instruction-11.png": "721bf83941fdaa8d5057360ebc8745c9",
"assets/assets/desktop-icon-area-01-03-normal.png": "d03af941b1fc591f5e94fadd9311240e",
"assets/assets/mobile-icon-newsfeed-post-addpic-normal.png": "1aad73111718b6f7a59c5446625c7ea6",
"assets/assets/desktop-icon-newsfeed-pic-delete.png": "7ea8a97a0702da3b4667b18f5562b9da",
"assets/assets/desktop-pic-nft-instruction-10.png": "4b3ca9f9349eb711033444a680deb973",
"assets/assets/mobile-icon-article-respond-pressed.png": "1e36ec915e181d3d1835bb6b1fe884af",
"assets/assets/desktop-icon-newsfeed-official-large.png": "3c5f9df140aba80c5929097cdb7ec719",
"assets/assets/desktop-pic-nft-instruction-06.png": "1c69435ba845da1b60a9f9395dd6d431",
"assets/assets/pic-successful.png": "ec592d5de1025e3058365b8401406982",
"assets/assets/mobile-icon-article-share-normal.png": "bbbbdc944f83f44ddad0cce884075057",
"assets/assets/desktop-pic-nft-instruction-07.png": "d1ed11f550748a5e6e45a05e57bc4ac6",
"assets/assets/desktop-pic-area-01.png": "81863f033f590c4eee9bb7d2c82fe9fb",
"assets/assets/desktop-pic-area-02-01.png": "66f874fcdbea02d0d8e2ca1cd75cb075",
"assets/assets/desktop-image-qpp-logo-01.png": "0b18780b1c359c5db9f5906cfbc96069",
"assets/assets/desktop-icon-commodity-nft-properties.png": "b2144bb089e4667e092bcff597e480ea",
"assets/assets/pic-commodity-largepic-sample-07.png": "6881ec14f540f514b1bfb2abeea05436",
"assets/assets/mobile-icon-newsfeed-article-public.png": "72aa7f2db54c656a0d42a425ec4f2986",
"assets/assets/desktop-icon-area-01-04-normal.png": "338ab824bc2b76a9a24058298ebf2ff0",
"assets/assets/desktop-icon-kv-registered.png": "ce5fc1148d4f1327ca238fbd53603084",
"assets/assets/desktop-pic-nft-instruction-22.png": "0951b48ae4eeedc4585c6e018a25d318",
"assets/assets/desktop-button-down-send-normal.png": "517d72b6f0a8d40b9475a53bdd731030",
"assets/assets/desktop-pic-nft-instruction-09.png": "67dce4f2a73ab171fc651c0b143a8dec",
"assets/assets/mobile-bg-kv-2.png": "556d6f5976227fb42b185270ca8d6764",
"assets/assets/desktop-pic-nft-instruction-23.png": "a07d013df8d26ab1d15193ea85eee8a2",
"assets/assets/desktop-pic-qpp-text.png": "0e6b48e4a10edf89bd0750edc1754ac1",
"assets/assets/mobile-icon-actionbar-profile-pressed.png": "5927ab50b36af2926ceb9452657ed2b8",
"assets/assets/mobile-icon-respond-send-normal.png": "042b63cefbbb56834cb11c61deadff90",
"assets/assets/desktop-icon-commodity-nft-stats.png": "c08f60de92f1895bfd5eed54f2b2440a",
"assets/assets/desktop-pic-nft-instruction-04.png": "2c5949e0732a93e7586aea72328dc372",
"assets/assets/desktop-pic-nft-instruction-01.png": "bd5eeb569083f451dc0fed80f2392f74",
"assets/assets/mobile-icon-actionbar-list-notice-normal.png": "091d75cad49fce3fdb09ba3c79381cff",
"assets/assets/mobile-bg-area-03.png": "17db4fd71234573ee3499aba591578e9",
"assets/assets/mobile-icon-actionbar-list-notice-pressed.png": "9ce6a284b5200c656e94f29745a85441",
"assets/assets/desktop-pic-platform-appstore.png": "09eb8cb09f4a6d3d333428d60b98b13c",
"assets/assets/icon-display-digital-object.png": "ca901fb843bfccc1e75200bd2e37a773",
"assets/assets/pic-empty-default.png": "33959ae064f3c8b31b81189380aea5ee",
"assets/assets/desktop-image-error.png": "290e574e3fe207190628db2cf2b2a601",
"assets/assets/mobile-icon-actionbar-language-normal.png": "c3fde565ec2a54e067ee516e91a2a7eb",
"assets/assets/desktop_bg_kv.png": "9e1345977132015da73dec041ee456e8",
"assets/assets/desktop-icon-arrowdown.png": "c23ae6c2ca38f53aae8f0b4bf5b58061",
"assets/assets/desktop-icon-reorganize.png": "19990e76828f65d761ede73e5a3f6314",
"assets/assets/bg-dialog.png": "0800941d96aaf639d710255e9237b095",
"assets/assets/mobile-icon-actionbar-close-normal.png": "493257af10dc4094b001a79f08a48750",
"assets/assets/desktop-icon-image-magnifier.png": "f2cc4b7dd8d2e3259e4261f29d888b67",
"assets/assets/mobile-pic-area-02-03.png": "d968c45d3dcab68fde8b93fa385de987",
"assets/assets/mobile-icon-article-respond-normal.png": "705024992ac1627a4ef8dbd378d9921f",
"assets/assets/mobile-icon-actionbar-list-normal.png": "32ef41e689c89b7db0dbb5fdeadfdb08",
"assets/assets/icon-display-treasure-2.png": "33a86fd061266858e85755927948e54f",
"assets/assets/mobile-image-newsfeed-avatar-large.png": "be3d732f95a4129abe6a141abd4c2a0c",
"assets/assets/mobile-icon-actionbar-list-profile-pressed.png": "866fde49c0a16e840de1743d26f54d1d",
"assets/FontManifest.json": "d751713988987e9331980363e24189ce",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/NOTICES": "395470f901d0610b851249a567c76ed0",
"assets/AssetManifest.json": "d58bd80de9fd4d3045d411994140469c",
"favicon.png": "0779870e0631e939f0c163de78855e77",
"main.dart.js": "d61316fb2a31a73f7bd58ed08b13f445",
"version.json": "56f24fd90e44b17e54e0681e894612bb",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea"};
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

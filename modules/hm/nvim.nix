{pkgs,inputs, ...}:{
  home.packages = [
       inputs.khanelivim.packages.x86_64-linux.default
       pkgs.vim  
];
}

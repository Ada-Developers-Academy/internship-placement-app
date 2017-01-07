// Use <# for underscore templates so we don't conflict with ERB
_.templateSettings = {
  interpolate: /\<\#\=(.+?)\#\>/g,
  escape: /\<\#\-(.+?)\#\>/g,
  evaluate: /\<\#(.+?)\#\>/g
};

const Util = {
  classForScore: function(score) {
    if (score > 20) {
      return 'excellent-match';
    } else if (score > 15) {
      return 'good-match';
    } else if (score > 9) {
      return 'mediocre-match';
    } else if (score) {
      return 'bad-match';
    } else {
      return undefined;
    }
  },
  removeScoreClasses: function(element) {
    element = $(element);
    element.removeClass('excellent-match');
    element.removeClass('good-match');
    element.removeClass('mediocre-match');
    element.removeClass('bad-match');
  }
}

$(document).ready(function() {
  const app = new ApplicationView({
    el: '#application',
    classroomData: window.classroomData
  });
});

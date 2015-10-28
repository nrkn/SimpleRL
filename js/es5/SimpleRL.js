(function () {
    'use strict';

    var viewport = document.getElementById('viewport'),
        map = [
            '####  ####',
            '#  ####  #',
            '#        #',
            '##      ##',
            ' #      # ',
            ' #      # ',
            '##      ##',
            '#        #',
            '#  ####  #',
            '####  ####'
        ],
        x = 2,
        y = 2;

    function setTile(tile) {
        map[y] = map[y].substr(0, x) + tile + map[y].substr(x + 1);
    }

    function movePlayer(newX, newY) {
        if (map[newY][newX] !== ' ') {
            return;
        }
        x = newX;
        y = newY;
    }

    function tick(e) {
        setTile(' ');

        switch (e.keyCode) {
        case 37:
            movePlayer(x - 1, y);
            break;
        case 38:
            movePlayer(x, y - 1);
            break;
        case 39:
            movePlayer(x + 1, y);
            break;
        case 40:
            movePlayer(x, y + 1);
            break;
        }
        setTile('@');
        viewport.innerHTML = map.join('<br />');
    }

    document.addEventListener('keyup', tick, false);
    tick({keyCode: null});
}());
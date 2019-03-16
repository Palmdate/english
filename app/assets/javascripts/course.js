document.addEventListener("turbolinks:load", function() {
    'use strict';

    var $dataTable = $('.student-grade-table');

    $dataTable.on('click', '.add', function(e) {
        var $row = $(this).closest('tr');
        if ($row.find('.course-select').val() == '' || $row.find('.grade-select').val() == '' || $row.find('.credits-select').val() == '') {
            $row.addClass('danger');
            return false;
        }
        addRow($row);
        $dataTable.deleteRow($row.length+1);
    })
        .on('click', '.edit', function(e) {
            var $row = $(this).closest('tr');
            showEdit($row);
        })
        .on('click', '.save', function(e) {
            var $row = $(this).closest('tr');
            if ($row.find('.course-select').val() == '' || $row.find('.grade-select').val() == '' || $row.find('.credits-select').val() == '') {
                $row.addClass('danger');
                return false;
            }
            saveRow($row);
        })
        .on('click', '.delete', function(e) {
            var $row = $(this).closest('tr');
            $row.fadeOut('slow', function() {
                $row.remove();
            });
        })
        .on('change', '.course-select', function(e) {
            var $row = $(this).closest('tr');
            updateCredits($row, $(this));
        });

    function showEdit($row) {
        $row.addClass('editing active').removeClass('saved');
    }

    function saveRow($row) {
        $row.removeClass('editing student-new-row warning danger error active').addClass('student-saved-row saved');
        var data = getColData($row);
        // updateCredits($row, $row.find('.course-select'));
        $row.find('.course').text(data.course.name).attr('data-course-code', data.course.val);
        $row.find('.grade').text(data.grade.name).attr('data-grade-val', data.grade.val);
        $row.find('.credits').text(data.credits.name).attr('data-credits-val', data.credits.val);
    }

    function addRow($row) {
        $row.after('<tr class="student-new-row active">' + $row.html() + '</tr>');
        $row.next().find('.course, .grade, .credits').text('');
        saveRow($row);
    }
    function updateCredits($row, $select) {
        $row.find('.credits').text($select.find('option:selected').data('credits'));
    }

    function getColData($row) {
        var col = {};
        col.course = {};
        col.grade = {};
        col.credits = {};
        col.course.name = $row.find('.course-select option:selected').text();
        col.course.val = $row.find('.course-select').val();
        col.course.credits = $row.find('.course-select option:selected').data('credits');
        col.grade.name = $row.find('.grade-select option:selected').text();
        col.grade.val = $row.find('.grade-select').val();
        
        col.credits.name = $row.find('.credits-select option:selected').text();
        col.credits.val = $row.find('.credits-select').val();

        return col;
     }
})

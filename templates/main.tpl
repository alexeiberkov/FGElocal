<!DOCTYPE html>
<html>
<head>
    <title>Fleetguard-UI PRE ALFA</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

</head>
<body>

<div class="container">
    <div id="appcontent">
    <h1>MeteoGroup/fleetguard-ui. </h1>
    {if $currentBranch}
    <h3>Текущая ветка <a href="{$appURL}"/>{$currentBranch}</a> <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></h3>
    {/if}

    <form action="{$workerURL}" method="post">
        <div class="row">
            <div class="panel panel-default">
                <div class="col-md-8">
                    <div class="panel-body">
                        <div class="list-group">
                            {foreach $allBranches as $branch}
                                <a href="#" class="list-group-item{if $branch == $currentBranch} active{/if}">{$branch}</a>
                            {/foreach}

                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="input-group">
                        <br/>
                        <input type="text" class="form-control" value="{$currentBranch}" id="branchName" name="branchName" readonly/>
                        <input type="hidden" id="config" name="config" />

                        <div class="btn-group btn-group-lg" role="group" aria-label="...">
                            <button type="submit" class="btn btn-default" value="dsrv">Хочу .dsrv</button>
                            <button type="submit" class="btn btn-default" value="tsrv">Хочу .tsrv</button>
                        </div>
                    </div>
                    <img src="http://3.bp.blogspot.com/-IR3xDLxF3NU/UYkEGFDhaxI/AAAAAAAAAFY/J3JJZwj0rlI/s1600/%D0%BF%D0%BE%D0%B2%D0%B0%D1%80+%D0%BE%D0%BD.png" />
                </div>
            </div>
        </div>
    </form>
    </div>
</div>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


<script type="text/javascript">

    $("form").submit(function() {
        if ($('#loading_image').length == 0) { //is the image on the form yet?
            // add it just before the submit button
            $('#appcontent').before('<img src="http://design.printexpress.co.uk/wp-content/uploads/2015/10/06-spinner.gif" style="display: none;" alt="loading" id="loading_image">')
        }
        $('#loading_image').show(); // show the animated image
        $('#appcontent').hide();
        $(':submit',this).attr('disabled','disabled'); // disable double submits
        return true; // allow regular form submission
    });
    
    $('a.list-group-item').click(function(e){
        e.preventDefault();
        const branchName = e.target.innerText;
        $("#branchName").val(branchName);
        return false;
    });

    $(':button').click(function(e){
        $("#config").val(e.target.value);
    });
</script>
</body>
</html>
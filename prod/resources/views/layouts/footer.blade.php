@extends('app')

@section('footer')

    <footer class="sticky-footer">
        <div class="container">
            <div class="text-center">
                <small>Copyright © <a title="Cloud Sindria" style="color: inherit;" href="https://cloud.sindria.org">Cloud Sindria</a> <?php echo date('Y'); ?></small>
            </div>
        </div>
    </footer>
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fa fa-angle-up"></i>
    </a>

    @include('components.modals.logout')

@endsection
